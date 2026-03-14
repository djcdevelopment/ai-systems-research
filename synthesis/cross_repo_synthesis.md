# Cross-Repo Synthesis — 2026-03-14

## Thesis

In a single 14-hour working session, the ecosystem transitioned from "repositories that share a directory" to "repositories that share a contract." The chatGPT_parser now produces a catalog-described, rank-cleaned projection set. Liveview now has a full workbench that consumes those projections with specialized rendering. The research repo now has formal architecture documentation naming what the system is. What remains is making the contract explicit enough to be tested across repo boundaries.

---

## 1. The ranking hygiene commit was the highest-leverage change

The suggestion queue went from ~49,000 raw candidates to a 250-item ranked queue with 83 hub groupings. This was not a cosmetic change — it introduced:

- A drop policy that eliminates unpresentable anchors (API endpoints, date-like paths, punctuation tokens)
- A 4-tier bucket classification (`strong_operational`, `supported_anchor`, `anchor_only`, `exploratory`)
- Per-anchor limits (12 for specific anchors, 4 for generic) with a frontloading window (first 40 entries limited to 3 per anchor)
- Canonical path normalization to prevent duplicate anchors from case/slash differences

**Why this matters for the system:** The workbench's QueuePairCards renderer shows max 12 cards per lane. If the queue contained thousands of low-quality entries, the UI would show whatever happened to be first — which would be noise. The ranking commit ensures that what reaches the UI has already been through a quality filter.

Evidence: `suggestion_queue.py:should_drop_candidate()`, `suggestion_queue.py:rank_candidate()`, `suggestion_queue.py:classify_queue_bucket()`

---

## 2. The workbench represents a new kind of capability

Previous liveview UI work was operational (telemetry graphs, session package inspection). The Projection Workbench is analytical — it lets a user:

- See the full catalog of available projection surfaces
- Filter by analytical layer (stable, review, suggestion)
- Apply score thresholds to focus on high-confidence suggestions
- Select an entity and see every surface that mentions it
- Compare two entities side-by-side
- Isolate an entity's neighborhood across both swimlane and graph views

This is a shift from "dashboard showing what happened" to "workbench for investigating why things are connected."

The read model derivation pattern (pure functions, no side effects, dependency-ordered `useMemo` chain) is architecturally clean and the 262-line integration test covers the derivation logic thoroughly. The untested frontier is component rendering and user interaction.

Evidence: `WorkbenchShell.tsx`, `deriveWorkbenchSwimlaneModel.ts`, `deriveWorkbenchGraphModel.ts`, `workbenchSwimlaneReadModel.test.cjs`

---

## 3. The audio pipeline extends the parser's reach but doesn't yet connect to the UI

The audio STT pipeline (605 lines of new transcription engine, 3 CLI commands, multi-provider support, parallel CPU transcription) is the largest single module added. It flows into projections via `typed_vs_voice.ndjson`, which classifies each conversation by modality.

But the connection to liveview is thin:
- `typed_vs_voice.ndjson` renders as `GenericRecordRows` (raw key-value display)
- The actual transcript text (`data/raw/transcripts/`) is not part of the projection set
- No workbench renderer understands voice/typed modality semantics

**Provisional observation:** The audio pipeline currently serves the parser's internal analytical needs (understanding which conversations used voice input). For it to serve the broader ecosystem, either:
- A specialized workbench renderer for modality data is needed, or
- The transcript text should flow into the search index so users can search voice content

Evidence: `audio_transcribe.py`, `builder.py:build_typed_vs_voice()`, `workbenchArtifactUtils.ts` (no `typed_vs_voice` kind in dispatch)

---

## 4. The catalog is the contract — and it's not yet committed

The `projection_catalog.json` is the architectural bridge between producer and consumer. It tells the workbench:
- What surfaces exist
- Which layer each belongs to
- What kind of rendering each needs
- Which surfaces are always-on vs. optional

Both sides agree on the catalog schema: chatGPT_parser emits it via `build_projection_catalog()`, liveview validates it via a Zod schema (`projectionCatalogSchema`).

But:
- `projection_catalog.json` is untracked in chatGPT_parser
- `catalog.py` is untracked in chatGPT_parser
- The Zod schema in liveview is committed but the producer isn't

This is the classic "handshake gap" — the contract exists in code on both sides but hasn't been stabilized through version control. Until both sides commit their catalog code, the contract is an informal agreement between two worktrees.

Evidence: chatGPT_parser git status (`?? data/projections/projection_catalog.json`, `?? src/chatgpt_parser/projections/catalog.py`), liveview `loadProjectionCatalog.ts` (Zod schema defined and validated)

---

## 5. The research repo is approaching a naming event

Three documents in the research repo's `plans/` directory represent the first attempt to formally name what this system is:

1. `current_architecture_overview.md` — names the 4-repo ecosystem and its core thesis
2. `architecture_contract_package.md` — defines producer contracts with 5 guarantee categories
3. `TODO_futureResearchTopics.md` — deferred research directions

Combined with the `archStandards` directory (dual-loop orchestration strategy), the system now has both an implementation architecture and a workflow architecture documented.

**What's missing:** A decision on the highest-risk ambiguity identified in the chatgpt-parser-assessment session: "Does the ecosystem want one shared artifact contract across all repos, or multiple producer-specific contracts with adapters?" The architecture documents describe what exists; they don't yet prescribe which direction to go.

---

## 6. Observed pattern: build-then-bridge

Across all repos, the work follows a consistent pattern:

1. **Build capability in isolation** — chatGPT_parser builds audio pipeline, liveview builds workbench, research repo writes architecture docs
2. **Connect through data** — projection files are the shared interface, catalog is the discovery mechanism
3. **Defer integration testing** — each repo has strong internal tests but no cross-repo validation

This pattern produces rapid capability growth at the cost of integration confidence. The 106 pytest tests and the liveview test suite each verify their own side of the contract, but nobody verifies that `build_projection_catalog()` output actually passes `projectionCatalogSchema.parse()`.

---

## 7. Concrete risks requiring attention

### High priority

1. **Commit the catalog.** `catalog.py` and `projection_catalog.json` in chatGPT_parser should be committed. This is the contract document that makes the workbench self-describing.

2. **Add a cross-repo contract test.** Even a single test that takes chatGPT_parser's catalog fixture and validates it against liveview's Zod schema would catch 80% of contract drift.

### Medium priority

3. **Fix the adversarial review bugs.** The unstable `useEffect` dependency on `filteredSessions` and unmemoized `selectDerivedSessions` are real performance issues in the existing liveview code (separate from the new workbench).

4. **Address entity ID collision.** The workbench's fuzzy entity matching (`findBestEntityMatch()` with substring contains) could produce false relationships. Consider requiring exact match and falling back to a "possibly related" signal.

5. **Unify score threshold semantics.** The score filtering in swimlane and graph models operates on different fields. Either document the intentional difference or unify.

### Lower priority

6. **Add keyboard accessibility to GraphSurface.** SVG nodes need ARIA roles and keyboard focus handlers.

7. **Build a typed-vs-voice renderer.** The modality data exists but renders as raw records. A simple bar chart or heatmap by conversation would make it useful.

8. **Persist overlay state.** The workbench resets all filters/selections on page load. localStorage or URL hash persistence would make it usable across sessions.

---

## Open questions

1. **Shared contract vs producer-specific adapters?** This is the architectural decision that gates everything else. If shared, the catalog schema should be defined in a neutral location (archStandards? research repo?). If per-producer, each repo needs an adapter layer.

2. **Should transcript text enter the search index?** The parser has a search_index.ndjson projection that covers conversations, artifacts, entities, and commands. Adding transcript text would make voice content searchable through the workbench.

3. **When does the projection catalog become a versioned contract?** Currently it's emitted by `build_projection_catalog()` without a version migration strategy. Adding or removing surfaces will break liveview's fallback hints.

4. **How should the research repo consume these changes?** The analysis and planning documents in `plans/` and `artifacts/sessions/` are the research repo's response to this work, but they're all uncommitted. Should they be packaged as a formal session artifact via `package-research-session.ps1`?
