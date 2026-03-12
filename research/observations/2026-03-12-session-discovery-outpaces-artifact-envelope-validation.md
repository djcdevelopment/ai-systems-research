# Observation

## Title
Contract boundary validation is strong at session discovery and weak at artifact-envelope loading

## Context
The research UI session explicitly evaluates whether the implementation matches a contract-first debugger architecture.

## Evidence
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` says `SESSION_LOG.jsonl` works as a practical strict boundary for session discovery.
- `artifacts/sessions/2026-03-11-liveview-ui/system_snapshot.md` states that `src/validation/researchSchemas.ts` defines the strict discovery boundary for session entries.
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` also states that artifact envelopes are not validated at load time and that `SessionArtifact` only guarantees filename, derived key, media type, and `unknown` content.
- `artifacts/sessions/2026-03-11-liveview-ui/strategy_context_reduction.md` recommends adding a strict artifact envelope schema and validating every JSON artifact at load time.
- `artifacts/sessions/2026-03-11-liveview-ui/request_log.json` records the visible gap as renderer mismatch displayed inline but not surfaced as telemetry or diagnostics state.

## What Happened
The implementation established a strict contract at the point where sessions enter the UI, but it did not establish an equally strict contract at the point where individual artifacts are loaded and dispatched to renderers.

## Why It Matters
This is a concrete contract-boundary finding, not a speculative one. It shows that the current system validates "which session exists" more strongly than "what artifact was actually received," leaving the downstream renderer layer to absorb schema drift and mismatch.

## Short Pattern Explanation
Discovery contracts have matured faster than payload contracts, so validation strength drops after the session index boundary.
