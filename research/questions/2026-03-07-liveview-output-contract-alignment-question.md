# Question

## Core Question
For `system_id: liveview`, which output location should be treated as canonical for research ingestion: `ingest/out` or `artifacts/sessions/`?

## Why This Matters
Research traceability depends on a stable and unambiguous handoff path from implementation artifacts to research artifacts.
If the canonical output path is unclear, downstream observation and synthesis quality may degrade.

## Subquestions
- Should `SYSTEM_INDEX.md` continue to list `artifact_outputs: artifacts/sessions/` if current evidence shows active outputs under `ingest/out`?
- Should `liveview` emit both paths, or should research tooling map `ingest/out` to session artifacts?
- Is `artifacts/sessions/` planned but not yet implemented in the current branch/state?

## Related Artifacts
- `research/snapshots/2026-03-07-liveview-ingest-out-snapshot.md`
- `research/observations/2026-03-07-liveview-ingest-retention-observation.md`
- `D:\work\liveView\RESEARCH_LINK.md`
- `D:\work\ai-systems-research\SYSTEM_INDEX.md`
- `D:\work\liveView\SNAPSHOT_CONTRACT.md`
