# System Snapshot

## Components
- `chatGPT_parser` projection producer
- `liveView/ui` projection catalog consumers
- `ai-systems-research` research/session packaging boundary
- Local session artifact bundle in `D:\work\liveView\artifacts\sessions\20260410-222906`

## Data Flow
- `graph_manifest.json` in `chatGPT_parser` provides `build_time`
- `D:\work\chatGPT_parser\src\chatgpt_parser\projections\builder.py` passes that value into `build_projection_catalog`
- `D:\work\chatGPT_parser\src\chatgpt_parser\projections\catalog.py` writes `projection_catalog.json` with `catalog_version`, `snapshot_id`, `generated_at`, and `surfaces`
- `D:\work\liveView\ui\src\data\loadProjectionCatalog.ts` parses the catalog
- `D:\work\liveView\ui\src\data\loadSessionPackage.ts` and `D:\work\liveView\ui\src\data\loadObservatoryData.ts` consume the parsed catalog
- This session bundle is packaged into `D:\work\ai-systems-research\artifacts\sessions\20260410-222906` and logged in `SESSION_LOG.jsonl`

## Artifact Contracts
- Producer contract artifact: `projection_catalog.json`
- Producer top-level fields now used in this session: `catalog_version`, `snapshot_id`, `generated_at`, `surfaces`
- Surface fields used in this session: `name`, `layer`, `kind`, `stability`, `always_on`, `depends_on`, `description`
- Canonical research/session package artifacts used in this session:
- `lesson_learned.md`
- `complexity_inflection_points.md`
- `strategy_context_reduction.md`
- `research_bridge.md`
- `system_snapshot.md`
- Optional artifact included in this session: `request_log.json`

## Key Files
- `D:\work\chatGPT_parser\src\chatgpt_parser\projections\catalog.py`
- `D:\work\chatGPT_parser\src\chatgpt_parser\projections\builder.py`
- `D:\work\chatGPT_parser\tests\test_projections_builder.py`
- `D:\work\liveView\ui\src\data\loadProjectionCatalog.ts`
- `D:\work\liveView\ui\src\data\loadObservatoryData.ts`
- `D:\work\liveView\ui\src\validation\projectionCatalogSchemas.ts`
- `D:\work\liveView\ui\tests\observatoryDataLoader.test.cjs`
- `D:\work\ai-systems-research\ARTIFACT_SCHEMA.md`
- `D:\work\ai-systems-research\package-research-session.ps1`
