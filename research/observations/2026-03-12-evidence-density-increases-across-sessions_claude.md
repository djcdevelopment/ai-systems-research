# Observation

## Title
Evidence density in session artifacts increases as producer tooling matures, from narrative to verified-with-evidence

## Context
The three sessions represent three different levels of evidence grounding. Comparing the same artifact types across sessions reveals a clear progression in how claims are supported.

## Evidence
- `artifacts/sessions/2026-03-09-conversation-ledger/lesson_learned.md` contains narrative claims with no file references, no `Verified:` markers, and no code evidence. Example: "AI-assisted development enables rapid regeneration of implementations" appears as a bullet point without supporting evidence.
- `artifacts/sessions/2026-03-09-conversation-ledger/research_bridge.md` lists observations as bare bullets under `## Evidence` with no source attribution.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/lesson_learned.md` introduces structural claims ("START_HERE.md + SESSION_LOG.jsonl reduce restart cost to two files") but still without file:line references.
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/session_reasoning_graph.json` introduces machine-readable reasoning nodes but without evidence arrays populated.
- `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md` uses explicit `Verified:` and `Inference:` markers throughout, with file:line references such as `src/App.tsx:64-84`, `src/data/loadSessionIndex.ts:27-50`, and `src/lib/restartContext.ts:107-143`.
- `artifacts/sessions/2026-03-11-liveview-ui/system_snapshot.md` grounds every observation in specific source files with line ranges.
- `artifacts/sessions/2026-03-11-liveview-ui/request_log.json` and `session_reasoning_graph.json` include structured `verified_observations` arrays with `claim` and `evidence` fields.

## What Happened
Session 1 produces narrative artifacts with implicit evidence. Session 2 introduces structural claims and machine-readable formats but with minimal evidence linkage. Session 3 makes the evidence-to-claim relationship explicit, traceable, and machine-parseable.

## Why It Matters
This is distinct from the schema evolution observation (which tracks artifact set completeness and heading conformance). This pattern is about the quality of individual claims within artifacts. It suggests that the producer tooling and methodology determine claim quality more than the schema definition alone. A downstream research consumer can trust session 3 artifacts differently from session 1 artifacts, and any analysis pipeline should account for this variation.

## Short Pattern Explanation
Artifact evidence density tracks producer capability, not schema version. The same schema produces narrative, structural, and verified-with-evidence artifacts depending on how the session was conducted.
