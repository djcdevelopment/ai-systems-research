# Complexity Inflection Points

## Decision Point
- Decide whether to make `liveView/ui` less strict, make `chatGPT_parser` publish the missing metadata, or do both in a bounded way.

## Before
- `projection_catalog.json` from `chatGPT_parser` exposed `catalog_version`, `snapshot_id`, and `surfaces`, but not `generated_at`.
- Workbench treated `generated_at` as required and fell back when validation failed.
- Observatory loaded the same artifact without validation, so the same file had two authority rules inside one consumer repo.
- Some fallback `kind` aliases in `liveView/ui` used shorter local names than the producer catalog.

## After
- `chatGPT_parser` now emits `generated_at` in `projection_catalog.json`.
- The producer derives `generated_at` from `graph_manifest.build_time` instead of inventing a new timestamp source.
- `liveView/ui` accepts legacy catalogs without `generated_at` but normalizes them through the shared projection catalog parser.
- Observatory and Workbench now parse the catalog through the same validation path.

## Why Complexity Increased or Decreased
- Complexity decreased in the consumer because one artifact now has one parsing path.
- Complexity increased slightly across repos because the fix had to be made at the contract boundary, not only in one codebase.
- That cross-repo increase was justified because relaxing the UI alone would have preserved an incomplete producer contract.

## Trigger Signals
- A produced artifact is considered authoritative in one consumer path and optional or inferred in another.
- The producer and consumer disagree on whether a top-level field is required.
- Fallback hints introduce vocabulary that is not identical to published producer values.
- Tests assert structural subsets but do not cover the exact contract fields used by downstream consumers.
