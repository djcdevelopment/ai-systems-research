# Context Reduction Strategy

## Goal

- Produce a research session bundle for `chatgpt_parser` that is grounded in current implementation reality while keeping the inspection set small enough for downstream synthesis and UI teams.

## Context Retained

- Contract authority from `ai-systems-research`:
  - `ARTIFACT_SCHEMA.md`
  - `package-research-session.ps1`
- Current producer framing:
  - `README.md`
  - `docs/architecture/CURRENT_ARCHITECTURE_OVERVIEW.md`
- Current execution surface:
  - `src/chatgpt_parser/cli.py`
- Current runtime evidence:
  - `data/graph/graph_manifest.json`
  - `data/graph/graph_warning_triage.json`
  - `data/projections/snapshot_manifest.first_full_dataset.json`
  - `data/projections/projection_validation.json`
  - `data/projections/projection_catalog.json`
- Current regression confidence:
  - `tests/test_graph_builder.py`
  - `tests/test_projections_builder.py`
  - `pytest` status `63 passed, 3 warnings`

## Context Removed

- Low-level extractor implementation details not needed for a contract-facing research pass.
- Superseded incremental planning prompts once their behavior was already materialized in emitted artifacts.
- Raw dump file listings and asset filenames beyond the counts and resolution outcomes already captured in manifests.
- Consumer-specific UI speculation beyond what is now directly supported by `projection_catalog.json`.

## Result

- The minimum viable context for understanding the current system is now:
  1. architecture overview
  2. CLI surface
  3. graph manifest + warning triage
  4. snapshot manifest + projection validation
  5. projection catalog

## Next Step Protocol

- For any new consumer or research pass:
  1. read `data/projections/projection_catalog.json`
  2. read `data/projections/snapshot_manifest.<snapshot_id>.json`
  3. read `data/projections/projection_validation.json`
  4. read `data/graph/graph_warning_triage.json`
  5. inspect only the specific projection layer relevant to the task
- If suggestion-layer surfaces are involved, start from:
  - `suggestion_viewport.json`
  - `why_connected_queue.ndjson`
  - `hub_suggestions.ndjson`
  and avoid starting from raw candidates unless debugging ranking behavior.
