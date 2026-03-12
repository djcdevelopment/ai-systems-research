# Question

## Core Question
How should session artifact producers declare schema version and conformance level when the canonical schema is still changing?

## Why This Matters
Current evidence shows both schema expansion and incomplete adoption. Without an explicit version or conformance marker, downstream consumers cannot reliably distinguish:

- older sessions created before a field existed
- intentionally reduced artifacts
- malformed artifacts
- prototype-only extensions

## Evidence Prompting The Question
- `artifacts/sessions/2026-03-09-conversation-ledger/` lacks several artifacts later listed in the recommended session folder shape in `ARTIFACT_SCHEMA.md`.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/request_log.json` uses a reduced JSON shape relative to the canonical `request_log.json` definition in `ARTIFACT_SCHEMA.md`.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/research_bridge.md` and `artifacts/sessions/2026-03-11-liveview-ui/research_bridge.md` do not match the exact heading template defined in `ARTIFACT_SCHEMA.md`.
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` explicitly notes that artifact schema versioning and envelope metadata are still undecided outside the UI.

## Subquestions
- Should version be declared per artifact, per session folder, or both?
- Should artifacts distinguish `canonical`, `legacy`, and `prototype` conformance levels?
- Should research tooling ingest partial artifacts differently when non-conformance is declared explicitly?

## Related Artifacts
- `ARTIFACT_SCHEMA.md`
- `artifacts/sessions/2026-03-09-conversation-ledger/lesson_learned.md`
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/request_log.json`
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md`
