# Context Reduction Strategy

## Goal
- Finish the projection catalog contract fix end to end without reopening the full earlier cross-repo exploration.

## Context Retained
- `D:\work\liveView\AGENTS.md`
- `D:\work\liveView\RESEARCH_LINK.md`
- `D:\work\liveView\PROJECT_CONTEXT.md`
- `D:\work\liveView\SNAPSHOT_CONTRACT.md`
- `D:\work\ai-systems-research\ARTIFACT_SCHEMA.md`
- The exact producer files, consumer files, and tests touched by the fix
- Verified test outcomes for `liveView/ui` and `chatGPT_parser`
- The external packaging boundary in `D:\work\ai-systems-research\package-research-session.ps1`

## Context Removed
- Unrelated dirty-worktree files in `liveView`, `chatGPT_parser`, and `ai-systems-research`
- Earlier broader architecture discovery across all viewers and repos
- The missing `D:\work\ai-agent-research` path, except as a resolved note that it is not the active downstream handoff target
- Visual or historical questions that were not needed to ship the contract fix

## Result
- The remaining task became a bounded sequence:
- emit canonical session artifacts for the implemented fix
- package them into the research repo
- add the missing producer-side contract note so the boundary is documented in code and docs

## Next Step Protocol
- Read `AGENTS.md`, `RESEARCH_LINK.md`, `PROJECT_CONTEXT.md`, `SNAPSHOT_CONTRACT.md`, and `ARTIFACT_SCHEMA.md`.
- Inspect the producer catalog builder, the shared consumer parser, each consumer entry point for the catalog, and the relevant tests.
- Patch the producer to publish deterministic metadata and patch the consumer so all entry points share one parser.
- Run `npm test`, `npm run build`, focused parser projection tests, and the full parser pytest suite.
- Emit canonical artifacts and package them through `package-research-session.ps1`.
