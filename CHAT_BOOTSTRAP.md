# Chat Bootstrap — 2026-03-14

## System

4-repo ecosystem. Artifacts are the interoperability layer.

```
chatGPT_parser  →  projection artifacts  →  liveview/ui workbench
    (producer)        (contract surface)        (consumer)

ai-systems-research  ←  observes all three
archStandards        ←  workflow philosophy (dual-loop orchestration)
```

## Recent work (2026-03-13 evening session)

### chatGPT_parser (2 commits, pushed)
- **Audio STT pipeline**: `transcribe-audio` command, 3 providers (openai, local-whisper, faster-whisper), sidecar contract with `schema_version`, `audio_role`, `status`. 605-line `audio_transcribe.py`. Flows into `typed_vs_voice.ndjson` projection.
- **Projection ranking cleanup**: 49K raw candidates → 250 ranked queue, 83 hub groups. Drop policy, 4-tier bucket classification, frontloading, anchor dedup.
- **106 tests passing.** Worktree has 16 regenerated projection files + untracked `projection_catalog.json` and `catalog.py`.

### liveview/ui (all uncommitted)
- **Projection Workbench v2**: 14 components, 7 read models, 1 integration test. Swimlane/graph/split layouts. Inspector with 4 tabs. Score threshold, entity filter, isolation mode, cross-highlighting, compare mode.
- TypeScript clean, all tests pass, dist built.

### ai-systems-research (uncommitted)
- 2 chatgpt-parser research sessions (staged + untracked)
- 2 independent portfolio reviews (adversarial + sympathetic)
- Architecture overview + contract package in `plans/`
- This analysis: `analysis/` and `synthesis/` directories

## Key contract

`projection_catalog.json` — bridge between producer and consumer.
- chatGPT_parser emits via `build_projection_catalog()` in `catalog.py` (UNTRACKED)
- liveview validates via Zod schema in `loadProjectionCatalog.ts` (committed)
- Schema: `{ catalog_version, snapshot_id, generated_at, surfaces[].{name, layer, kind, stability} }`

## Critical gaps

1. **Catalog not committed** in chatGPT_parser — contract exists in two worktrees but not in version control
2. **No cross-repo contract test** — nobody validates producer output against consumer schema
3. **Audio projection unvisualized** — `typed_vs_voice.ndjson` renders as raw key-value rows, no specialized renderer
4. **Undecided**: shared artifact contract vs producer-specific contracts with adapters

## Next tasks

1. Commit `catalog.py` + `projection_catalog.json` in chatGPT_parser
2. Add cross-repo contract test (catalog fixture → Zod schema)
3. Formalize the projection contract as a versioned document
4. Decide shared-contract vs adapter architecture

## Key files to read first

| Repo | File | Why |
|------|------|-----|
| ai-systems-research | `synthesis/cross_repo_synthesis.md` | Full synthesis of today's work |
| ai-systems-research | `analysis/cross_repo_analysis.md` | Contract drift risks |
| ai-systems-research | `plans/research/architecture_contract_package.md` | Proposed contract definitions |
| chatGPT_parser | `src/chatgpt_parser/projections/builder.py` | Projection build pipeline |
| chatGPT_parser | `docs/AUDIO_STT_STATUS_2026-03-13.md` | Audio pipeline status + caveats |
| liveview/ui | `src/components/research/WorkbenchShell.tsx` | Workbench state owner |
| liveview/ui | `plans/pipeline/workbench-v2/ARCHITECTURE.md` | 4-layer architecture |
