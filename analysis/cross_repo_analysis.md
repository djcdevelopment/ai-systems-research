# Cross-Repo Analysis — 2026-03-14

## Evidence Window

- **Time range:** ~14 hours ending 2026-03-14 02:04 UTC-7
- **Repos with changes:** chatGPT_parser (2 commits + worktree), liveview/ui (all uncommitted), ai-systems-research (staged + untracked), archStandards (2 new files, not a git repo)
- **Evidence bundle:** `runs/2026-03-14_020436-cross-repo-delta/`

---

## Repo-by-repo summary

### chatGPT_parser

| Item | Detail |
|------|--------|
| Commits | 2 on `main` |
| Lines added/removed | +3,515 / -10 (STT) and +10,036 / -43,799 (ranking) |
| New CLI commands | `transcribe-audio` |
| New modules | `audio_transcribe.py` (605 lines) |
| Tests | 106 passing |
| Key change | Full audio STT pipeline + suggestion ranking overhaul |

### liveview/ui

| Item | Detail |
|------|--------|
| Commits | 0 (uncommitted) |
| New files | ~22 source files, 7 planning docs, 1 test |
| Build | TypeScript clean, all tests pass, dist generated |
| New dependency | `react-resizable-panels` |
| Key change | Complete Projection Workbench v2 UI |

### ai-systems-research

| Item | Detail |
|------|--------|
| Commits | 0 in window |
| Staged | 7 files in `artifacts/sessions/2026-03-13-chatgpt-parser-contract-research/` |
| Untracked | 6 files in `artifacts/sessions/2026-03-13-chatgpt-parser-assessment/`, 2 independent reviews, 3 architecture planning docs |
| Key change | First architecture overview + contract package formalizing the 4-repo ecosystem |

### archStandards

| Item | Detail |
|------|--------|
| Git | Not a git repo |
| Files | 2 new: `README.md`, `STRATEGY_OVERVIEW.md` |
| Key change | Codifies dual-loop orchestration strategy (Web Chat = strategic, CLI = deterministic) |

---

## Architectural handshake: parser outputs → liveview inputs

### The data contract

chatGPT_parser produces projection output files in `data/projections/`. The workbench consumes them via file upload.

**Producer (chatGPT_parser):**
```
build-projections
  → projection_catalog.json          (manifest of surfaces)
  → why_connected_candidates.ndjson   (raw scored pairs)
  → why_connected_queue.ndjson        (ranked top-250)
  → hub_suggestions.ndjson            (grouped by anchor)
  → suggestion_viewport.json          (viewport summary)
  → timeline.ndjson, artifact_index.ndjson, ... (12 stable projections)
  → typed_vs_voice.ndjson             (audio modality classification)
```

**Consumer (liveview/ui WorkbenchShell):**
```
loadSessionPackageFromFiles(FileList)
  → parseProjectionCatalog(file)     (Zod-validated)
  → for each file:
      NDJSON → Record<string, unknown>[]
      JSON   → Record<string, unknown>
      MD     → string
  → deriveWorkbenchCatalogBrowserModel(pkg)
  → deriveWorkbenchEntityIndex(pkg)
  → deriveWorkbenchSwimlaneModel(...)
  → deriveWorkbenchGraphModel(...)
  → deriveWorkbenchInspectorModel(...)
```

### Contract alignment

The handshake works because both sides agree on:

1. **File format:** NDJSON for multi-record surfaces, JSON for summaries, markdown for text
2. **Catalog schema:** `projection_catalog.json` with `surfaces[].{name, layer, kind, stability}`
3. **Surface layer vocabulary:** `stable_projection`, `review_surface`, `suggestion_layer`, `manual_overlay`, `continuity_inference`
4. **Surface kind vocabulary:** Used by liveview's lane renderers to dispatch to `CandidateScoreHeatmap` (kind: `why_connected_candidates`), `QueuePairCards` (kind: `why_connected_queue`), `HubCards` (kind: `hub_suggestions`)

### What makes it work today

- The catalog is the bridge document — it tells liveview which files exist, what layer and kind each belongs to
- Liveview has fallback surface hints for ~25 known filenames, so it works even without a catalog
- Entity extraction uses generic key scanning (`left`, `right`, `hub`, `label`, etc.) rather than specific schema knowledge
- The workbench never writes back to the parser's data — it's purely observational

---

## Contract drift risks

### 1. Catalog not yet committed

`projection_catalog.json` exists in chatGPT_parser's worktree (untracked) and is emitted by `build_projection_catalog()` in the also-untracked `catalog.py`. Liveview's workbench already expects it and validates it with a Zod schema. But the producer code isn't committed — if the catalog format changes before commit, the contract could silently break.

**Evidence:** `data/projections/projection_catalog.json` listed as untracked in git status; liveview test fixtures reference catalog format.

### 2. Score threshold duplication

The suggestion layer's score semantics are interpreted independently in two places:

- chatGPT_parser: `build_queue_record()` computes `_score` as a 6-tuple and assigns `confidence` (high/medium/low)
- liveview/ui: `deriveWorkbenchSwimlaneModel.ts` applies `scoreThreshold` to surface-level records, `deriveWorkbenchGraphModel.ts` checks edge weights

These operate on different score fields (`confidence` string vs numeric `_score` vs record-level numeric fields). The UI's score slider filters on numeric values in records, while the parser's scoring is ordinal (tuple-ranked). If a user adjusts the UI score threshold, they're filtering on a different axis than the parser's confidence classification.

**Risk:** User sees score threshold filtering but doesn't realize it operates differently per surface kind.

### 3. Entity ID namespace collision

chatGPT_parser emits entity IDs as node_ids from the graph (e.g., `entity:pyproject.toml`). Liveview normalizes them via `trim().toLowerCase()`. The parser's `EntityIndexRecord` and the workbench's `normalizeWorkbenchEntityId()` both do case-insensitive normalization, but:

- Parser uses `sha256_text()` for some IDs (deterministic but opaque)
- Workbench uses fuzzy `findBestEntityMatch()` with substring matching
- Two entities from different surfaces that share a normalized label will be merged in the workbench

**Risk:** Entity merging could create false relationships in the graph view.

### 4. Typed-vs-voice projection is new and unvisualized

The audio pipeline's primary projection output (`typed_vs_voice.ndjson`) flows through `build-projections` into the projection set. Liveview's workbench will render it as `GenericRecordRows` (the catch-all renderer) since there is no specialized renderer for it. The data contains `voice_message_count`, `audio_asset_count`, `transcript_count` per conversation — potentially valuable but currently shown as raw key-value pairs.

**Evidence:** No `typed_vs_voice` kind mapping in liveview's lane dispatch logic.

### 5. Audio sidecar data not visible to liveview

The transcript sidecars themselves (`data/raw/transcripts/<audio_id>.json`) are individual JSON files, not part of the projection set. Liveview has no mechanism to load or display them. The linked `audio_transcripts.ndjson` index is consumed by `build-projections` to produce `typed_vs_voice.ndjson`, but the actual transcript text is not surfaced.

---

## Missing tests

### Cross-repo integration tests

Neither repo has tests that verify the contract end-to-end:

1. No test takes chatGPT_parser's actual `build-projections` output and feeds it to liveview's `loadSessionPackageFromFiles()`
2. No test validates that the catalog Zod schema in liveview matches the catalog emitted by `build_projection_catalog()`
3. No test verifies that the surface kinds used in chatGPT_parser's catalog match the renderer dispatch keys in liveview

### Unverifiable assumptions

1. **Liveview assumes entity keys are stable across projection rebuilds.** If chatGPT_parser changes its graph ID generation, previously pinned entities in liveview would become orphans.
2. **Liveview assumes suggestion-layer surfaces always have numeric score fields.** If a new suggestion surface uses string scores, the threshold filter would silently pass everything.
3. **chatGPT_parser assumes transcription sidecars will be consumed via `link-transcripts`.** There's no validation that the sidecar format is compatible with the linker beyond the unit tests.

---

## Net-new leverage

### What the combination creates

The two repos, taken together, now form a complete **observe → analyze → visualize** loop for ChatGPT conversation data:

```
ChatGPT export (raw JSON)
  → chatGPT_parser: ingest → build-graph → build-projections
    → 24+ projection surfaces including:
      - ranked suggestion queue (250 entries, de-noised)
      - hub suggestions (83 grouped anchors)
      - typed-vs-voice modality classification (audio pipeline)
      - full-text search index, timeline, artifact lineage
  → liveview/ui Projection Workbench:
    - browse catalog of available surfaces
    - swimlane view: specialized renderers for candidates, queues, hubs
    - graph view: entity relationship network
    - inspector: drill into entity details, compare two entities
    - filter by layer, score threshold, entity text, isolation mode
```

### Specific leverage points

1. **Ranking hygiene directly improves UI quality.** The drop policy, bucket classification, and anchor deduplication in chatGPT_parser mean the workbench's QueuePairCards and HubCards show high-signal suggestions rather than noise. The reduction from 49K raw candidates to 250 ranked entries is the critical enabler for the UI to be useful.

2. **The catalog makes the workbench self-describing.** With `projection_catalog.json`, users don't need to know which files exist or what they contain — the workbench renders the available surfaces automatically with correct layer assignment and kind-based rendering.

3. **The entity index creates a cross-surface navigation layer.** By scanning all records for entity mentions, the workbench allows users to select an entity in the graph and see every surface that references it in the inspector. This cross-surface linking doesn't exist in the parser's raw output — it's emergent from the workbench's read model derivation.

4. **Audio pipeline extends modality coverage.** The `typed_vs_voice` projection adds a new analytical dimension — which conversations used voice input vs typed — that was previously invisible. Even though the workbench doesn't have a specialized renderer for it yet, it shows up as a browsable surface.

---

## archStandards contribution

The `archStandards` directory (created at 20:48 on 3/13) formalizes the workflow philosophy that all the other repos implement:

- **Dual-Loop Architecture:** High-entropy (Web Chat strategy) → Low-entropy (CLI implementation)
- **Artifact-Driven Continuity:** Files are the shared memory, not chat history
- **Reasoning as Pipeline:** Planning → Execution → Validation → Synthesis

This is a meta-document — it doesn't contain code — but it provides the vocabulary and mental model that explains why the repos are structured the way they are (parser produces artifacts, research interprets them, liveview renders them).

---

## ai-systems-research contributions

Three distinct bodies of uncommitted work:

1. **chatGPT_parser research sessions:** Two session packages (one staged, one untracked) assessing chatGPT_parser's evolution from simple export parser to multi-surface evidence producer. Key finding: "Artifact-driven development scales best when producer-specific pipelines are paired early with explicit cross-repo handoff contracts."

2. **Independent portfolio reviews:** One adversarial, one sympathetic review of the liveView portfolio. The adversarial review found real bugs (unstable `useEffect` dependency on `filteredSessions`, unmemoized `selectDerivedSessions` selector, O(n^2) force layout, quadruplicated `isRecord` definition, unsafe cast in `loadSessionPackage.ts:90`).

3. **Architecture planning documents:** A 600-line `current_architecture_overview.md` formally naming the 4-repo ecosystem and its core thesis: "artifacts are the interoperability layer." Plus an `architecture_contract_package.md` with formal producer contract definitions.
