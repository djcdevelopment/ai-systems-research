# Lesson Learned

## What Happened

- `chatgpt_parser` moved beyond a parser-only role into a contract-shaped corpus producer with durable evidence, multimodal sidecars, canonical graph outputs, stable projections, review surfaces, and suggestion-layer outputs.
- The current CLI surface in `src/chatgpt_parser/cli.py` now supports end-to-end ingest, graph build, multimodal indexing/linkage, projection build, and post-run artifact generation.
- A real first-run rebuild now produces 380 conversations, 19045 messages, 28603 graph nodes, 97574 graph edges, and 24 projection-side outputs according to `data/projections/snapshot_manifest.first_full_dataset.json`.

## What Worked

- Contract-first sidecars reduced ambiguity:
  - `data/graph/graph_manifest.json`
  - `data/graph/graph_warning_triage.json`
  - `data/projections/projection_validation.json`
  - `data/projections/projection_catalog.json`
- The repo’s test surface stayed ahead of growth: `pytest` currently reports `63 passed, 3 warnings`.
- The suggestion layer became tractable only after adding trimmed and explainable outputs:
  - raw candidates: `why_connected_candidates.ndjson` = 49413
  - trimmed queue: `why_connected_queue.ndjson` = 250
  - grouped hubs: `hub_suggestions.ndjson` = 83

## What Failed

- Older cross-repo packaging examples drifted from the current research contract; the existing `ai-systems-research` bundle for `chatgpt_parser` is not canonical under the current required artifact set.
- Output volume crossed the point where filename discovery alone was sufficient for consumers; `liveView` and research consumers now need an explicit projection layer catalog.
- Two known graph warnings remain unresolved:
  - duplicate node ids across inputs (`352`)
  - one conversation with non-contiguous canonical indices

## Reusable Takeaway

- Once a producer repo starts emitting multiple review and suggestion surfaces, machine-readable discovery and packaging contracts become as important as the underlying extraction logic.
