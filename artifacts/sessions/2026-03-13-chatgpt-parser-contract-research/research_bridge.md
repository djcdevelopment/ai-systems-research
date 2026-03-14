# Research Bridge Artifact

## System

- `chatgpt_parser`

## Session Focus

- Package the current `chatgpt_parser` state into a contract-compliant research session using the canonical `ai-systems-research` packaging rules.
- Capture the repo’s current role as an external corpus producer with evidence, graph, projection, review, and suggestion layers.

## Evidence

- `README.md`
- `docs/architecture/CURRENT_ARCHITECTURE_OVERVIEW.md`
- `src/chatgpt_parser/cli.py`
- `data/graph/graph_manifest.json`
- `data/graph/graph_warning_triage.json`
- `data/projections/snapshot_manifest.first_full_dataset.json`
- `data/projections/projection_validation.json`
- `data/projections/projection_catalog.json`
- `docs/SESSION_CHANGELOG_2026-03-13.md`
- `tests/test_graph_builder.py`
- `tests/test_projections_builder.py`

## Observed Pattern

- `chatgpt_parser` now emits enough projection, review, and suggestion surfaces that downstream consumers should not discover outputs by filename guessing alone.
- The repo has already started responding to that pressure with contract artifacts such as `projection_catalog.json`, snapshot manifests, pipeline reports, and warning triage sidecars.

## Candidate Observation

- Once a producer repo crosses from “single-purpose parser” into “multi-surface evidence producer,” the next scaling constraint shifts from extraction quality to discoverability and contract clarity for downstream consumers.

## Open Questions

- Should `projection_catalog.json` become an ecosystem-level contract rather than remaining repo-local to `chatgpt_parser`?
- Should future research packaging consume producer manifests directly instead of requiring a separate evidence-to-research synthesis pass?
- Are duplicate node-id warnings expected to persist across future exports, or do they indicate a normalizable export-snapshot contract issue?
