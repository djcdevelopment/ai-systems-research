# Complexity Inflection Points

## Decision Point

- Introduce contract/report artifacts and a projection layer catalog instead of relying on file presence and README knowledge.
- Add trimmed suggestion outputs (`why_connected_queue.ndjson`, `hub_suggestions.ndjson`) instead of exposing only raw candidate explosions.

## Before

- Consumer repos had to infer meaning from projection filenames and local docs.
- Raw candidate surfaces were large enough to be hard to inspect directly:
  - `why_connected_candidates.ndjson` = 49413
- Earlier research packaging examples in `ai-systems-research` did not match the current canonical artifact set.

## After

- `data/projections/projection_catalog.json` now describes layer, stability, dependency, and intent for emitted surfaces.
- Suggestion outputs are staged:
  - raw candidate pairs
  - ranked queue
  - viewport summary
  - grouped hubs
- First-run hardening outputs make the dataset inspectable without code spelunking:
  - snapshot manifest
  - graph warning triage
  - projection validation
  - pipeline report

## Why Complexity Increased or Decreased

- Complexity increased because `chatgpt_parser` now serves downstream research and UI consumers, not just direct CLI users.
- Complexity decreased operationally because contract artifacts compress the number of files a consumer must inspect to understand current dataset state.
- The net effect is positive: the system has more outputs, but less hidden coupling.

## Trigger Signals

- `src/chatgpt_parser/cli.py` grew into a broad surface spanning ingest, graph, multimodal, projection, and report commands.
- `data/projections/snapshot_manifest.first_full_dataset.json` records `files = 24`.
- `data/projections/projection_catalog.json` introduces explicit layer categories:
  - `stable_projection`
  - `review_surface`
  - `suggestion_layer`
- `data/projections/projection_validation.json` passing all 25 checks showed the repo had crossed from experimental outputs into contract-sensitive packaging.
