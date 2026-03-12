# Observation

## Title
Session artifacts are evolving from portable narrative notes toward a fuller canonical session package, but conformance is still uneven

## Context
The artifact ledger now spans three sessions with different levels of structure:

- `artifacts/sessions/2026-03-09-conversation-ledger/`
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/`
- `artifacts/sessions/2026-03-11-liveview-ui/`

## Evidence
- `artifacts/sessions/2026-03-09-conversation-ledger/` contains markdown artifacts only and does not include `system_snapshot.md`, `request_log.json`, or `session_reasoning_graph.json`.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/system_snapshot.md` states that the session introduced `SESSION_LOG.jsonl` and `session_reasoning_graph.json`.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/request_log.json` records a reduced shape with `session_id` and `decisions`, which is smaller than the canonical `request_log.json` shape defined in `ARTIFACT_SCHEMA.md`.
- `artifacts/sessions/2026-03-11-liveview-ui/` includes the fuller artifact set plus additional analysis artifacts such as `analysis_prompt.md`.
- `artifacts/sessions/2026-03-11-liveview-ui/research_bridge.md` and `artifacts/sessions/2026-03-11-chat-artifact-protocol/research_bridge.md` do not use the exact heading structure defined under `## Schema: research_bridge.md` in `ARTIFACT_SCHEMA.md`.

## What Happened
Across the three sessions, the ledger moved from concept-capture artifacts to a more complete session package with restart and reasoning artifacts. At the same time, actual emitted files still vary from the canonical schema in both heading structure and JSON field shape.

## Why It Matters
This is evidence that the schema is not static documentation only; it is actively being operationalized. The uneven conformance is also evidence that schema evolution and producer adoption are happening at the same time, which creates a real contract-management problem for downstream research and UI tooling.

## Short Pattern Explanation
The artifact set is becoming richer and more machine-usable across sessions, but the producer side has not yet converged on one strict version of the schema.
