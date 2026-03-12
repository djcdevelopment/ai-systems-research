# Observation

## Title
Analysis prompts emerge as an unschematized meta-artifact that makes session interpretation reproducible

## Context
The liveview-ui session includes `analysis_prompt.md`, a file not defined in `ARTIFACT_SCHEMA.md` that captures the full instructions used to generate the session's other artifacts.

## Evidence
- `artifacts/sessions/2026-03-11-liveview-ui/analysis_prompt.md` specifies: repository scope, claims to verify, architectural stance to evaluate against, six specific analysis questions, and the exact output file set to produce.
- `ARTIFACT_SCHEMA.md` defines seven canonical artifact types (`lesson_learned.md`, `complexity_inflection_points.md`, `strategy_context_reduction.md`, `research_bridge.md`, `system_snapshot.md`, `session_reasoning_graph.json`, `request_log.json`). `analysis_prompt.md` is not among them.
- `artifacts/sessions/2026-03-09-conversation-ledger/` and `artifacts/sessions/2026-03-11-chat-artifact-protocol/` do not contain analysis prompts. Their artifacts were produced through different processes (manual conversation mapping and protocol design respectively).
- The analysis prompt in the liveview-ui session fully determines what the other artifacts contain. Without it, a downstream consumer could read the artifacts but could not reproduce or audit the interpretation process.

## What Happened
The liveview-ui session introduced a file that captures the interpretation directive itself, not just the interpretation results. This extends the artifact model from "what was produced" to "how production was directed." The earlier sessions lack this, which means their interpretation process is not recoverable from the artifact set alone.

## Why It Matters
If analysis prompts become a standard part of the session package, they provide:
- reproducibility: another operator or AI can re-run the same analysis against updated code
- auditability: the research consumer can evaluate whether the analysis scope was appropriate
- provenance: the link between "what was asked" and "what was found" is explicit

This is a natural extension of the artifact-first principle in `RESEARCH_CONTRACT.md` ("Research is artifact-first") applied to the research process itself.

## Short Pattern Explanation
The session that produced the highest-quality artifacts is also the only one that captured the analysis directive as an artifact. The interpretation process itself may need to be a first-class artifact.
