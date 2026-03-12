# Question

## Core Question
Do purely linear reasoning graphs indicate genuinely linear sessions, or does the current graph model fail to capture actual exploration branching?

## Why This Matters
If reasoning graphs are meant to support "cross-session pattern analysis (reasoning efficiency, recurring discovery branches)" as stated in `ARTIFACT_SCHEMA.md`, then graphs with no exploration branches provide no signal about reasoning efficiency. They are indistinguishable from a flat task list.

## Evidence Prompting The Question
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/session_reasoning_graph.json` contains 4 nodes in a purely linear chain (N1->N2->N3->N4), `minimal_path` equals the full node list, and no `exploration_branches` field is present.
- `artifacts/sessions/2026-03-11-liveview-ui/session_reasoning_graph.json` also records a linear graph with `verified_observations` and `soft_contract_points` but no branching or exploration nodes.
- `artifacts/sessions/2026-03-09-conversation-ledger/` has no `session_reasoning_graph.json` at all, so no comparison point for the earliest session.
- `ARTIFACT_SCHEMA.md` defines `exploration_branches` as "node sequences that were exploratory or redundant," which implies the model is designed to capture non-linear exploration. No existing graph uses this field.

## Subquestions
- Are producers generating graphs post-hoc (after the session conclusion) rather than during exploration, which would naturally flatten the graph?
- Is the minimal_path / exploration_branches distinction meaningful when all current graphs are purely linear?
- Should the schema require at least one exploration branch or explicitly mark when a session was genuinely linear?
- Would real-time graph emission during a session produce structurally different graphs than post-hoc reconstruction?

## Related Artifacts
- `ARTIFACT_SCHEMA.md` (schema definition for `session_reasoning_graph.json`)
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/session_reasoning_graph.json`
- `artifacts/sessions/2026-03-11-liveview-ui/session_reasoning_graph.json`
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` (notes reasoning graph as a restart-context input)
