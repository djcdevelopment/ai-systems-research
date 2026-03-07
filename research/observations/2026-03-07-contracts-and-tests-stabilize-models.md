# Observation

## Title
Explicit contracts and test coverage stabilized multi-model collaboration better than prompt cleverness

## Context
While building the liveView system, implementation responsibilities were separated across model contexts.
The ingest layer owned truth creation and normalization.
The UI layer owned interpretation and exploration of generated snapshots.

## Evidence
- liveView repo with separate ingest/ and ui/ directories
- contract files including PROJECT_CONTEXT.md and SNAPSHOT_CONTRACT.md
- ingest test run showing ~131 passing tests
- working UI against generated snapshots

## What Happened
Once system boundaries became explicit, model behavior improved.
The biggest improvement did not come from more elaborate prompting.
It came from clearer ownership, stronger interfaces, and sufficient tests to let implementation iterate safely.

## Why It Matters
This suggests that AI-assisted development becomes more reliable when treated as an architecture problem rather than a prompt-writing problem.
It also suggests that tests act as a governance layer when models are contributing to implementation.

## Open Questions
- How general is this pattern across other systems?
- When do contracts outperform prompt iteration most dramatically?
- Can the same structure support deeper synthesis and article generation?
