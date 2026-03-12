# Observation

## Title
The liveview research UI behaves like a representational debugger, but its mismatch handling is still local fallback rather than observability

## Context
The 2026-03-11 UI session tests whether a research interface can act as a debugger for artifact contracts.

## Evidence
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` says the split-shell model is viable for a debugger-style UI.
- `artifacts/sessions/2026-03-11-liveview-ui/system_snapshot.md` records separate telemetry and research shells, session discovery from `SESSION_LOG.jsonl`, structured renderers for `request_log.json` and `session_reasoning_graph.json`, and restart-context derivation with provenance and warnings.
- `artifacts/sessions/2026-03-11-liveview-ui/research_bridge.md` concludes that the prototype is a viable representational debugger.
- `artifacts/sessions/2026-03-11-liveview-ui/request_log.json` for `request_log.json` says renderer mismatch falls back to raw JSON instead of failing hard.
- `artifacts/sessions/2026-03-11-liveview-ui/session_reasoning_graph.json` for `session_reasoning_graph.json` says graph/read-model mismatch produces inline fallback, but not research-track telemetry.

## What Happened
The prototype can inspect sessions, interpret known artifact shapes tolerantly, and derive restart context with explicit warnings. When contracts do not match, it degrades gracefully to inline fallback instead of surfacing those events as first-class diagnostics.

## Why It Matters
This validates the debugger direction while also defining its current limit. The UI is already useful for inspection and interpretation, but it is not yet a full contract debugger because mismatch behavior is visible only in the local view state.

## Short Pattern Explanation
Debugger-like representation is working; debugger-like telemetry for contract drift is not yet present.
