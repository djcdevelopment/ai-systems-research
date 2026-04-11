# Research Bridge Artifact

## System
- Source system: `liveView`
- Upstream producer involved in this session: `chatGPT_parser`
- Downstream research repository: `ai-systems-research`
- Session artifact handoff boundary: `D:\work\ai-systems-research\package-research-session.ps1`

## Session Focus
- Harden the `projection_catalog.json` producer-consumer boundary so the catalog can function as an authoritative artifact rather than a best-effort hint.

## Evidence
- Producer change: `D:\work\chatGPT_parser\src\chatgpt_parser\projections\catalog.py` now includes `generated_at` in the published catalog.
- Producer change: `D:\work\chatGPT_parser\src\chatgpt_parser\projections\builder.py` sources catalog `generated_at` from `graph_manifest.build_time`.
- Consumer change: `D:\work\liveView\ui\src\data\loadObservatoryData.ts` now parses `projection_catalog.json` through the same shared loader path used elsewhere in the UI.
- Consumer change: `D:\work\liveView\ui\src\validation\projectionCatalogSchemas.ts` remains backward-tolerant for catalogs that predate the metadata fix.
- Verification:
- `D:\work\liveView\ui`: `npm test` passed
- `D:\work\liveView\ui`: `npm run build` passed
- `D:\work\chatGPT_parser`: `tests\test_projections_builder.py` passed
- `D:\work\chatGPT_parser`: full `pytest` passed with existing parser warnings only

## Observed Pattern
- A contract becomes operationally authoritative only when metadata provenance is published at the producer and every consumer entry point goes through one validation path.

## Candidate Observation
- Cross-repo artifact contracts stop drifting when provenance-bearing metadata and consumer parsing are centralized at the boundary rather than recreated locally.

## Open Questions
- Should producer-published non-stable surface `stability` values stay as `experimental`, or should they be split into consumer-facing labels such as `review` and `suggested`?
- Should `manual_overlay` and `continuity_inference` remain permanently consumer-local layers, or eventually become producer-published layers with explicit semantics?
- Should the research packaging script eventually validate artifact headings in addition to filenames so schema drift is caught earlier?
