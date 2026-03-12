# Snapshot

## Title
Artifact ledger state at three sessions: the contract-boundary transition point

## Date
2026-03-12

## Scope
All artifacts under `artifacts/sessions/` as of this snapshot.

## Sessions

| Session | Date | System | Artifacts | Producer Type |
|---|---|---|---|---|
| 2026-03-09-conversation-ledger | 2026-03-09 | liveview | 5 files (4 md + 1 json) | human narrative mapping |
| 2026-03-11-chat-artifact-protocol | 2026-03-11 | research-hub | 7 files (5 md + 2 json) | human+AI protocol design |
| 2026-03-11-liveview-ui | 2026-03-11 | liveview | 8 files (6 md + 2 json) | AI code analysis |

## Schema Conformance Summary

| Artifact | Schema-defined Fields | Session 1 | Session 2 | Session 3 |
|---|---|---|---|---|
| lesson_learned.md | What Happened / What Worked / What Failed / Reusable Takeaway | conformant | divergent (custom headings) | divergent (numbered sections with Verified markers) |
| complexity_inflection_points.md | Decision Point / Before / After / Why / Trigger Signals | conformant | divergent (Inflection Point + Tradeoffs) | divergent (numbered tensions + inference) |
| strategy_context_reduction.md | Goal / Context Retained / Context Removed / Result / Next Step Protocol | conformant | divergent (progressive narrowing narrative) | divergent (implementation prescription with code refs) |
| research_bridge.md | System / Session Focus / Evidence / Observed Pattern / Candidate Observation / Open Questions | conformant | divergent (minimal evidence+questions list) | divergent (product requirements + architecture answer) |
| system_snapshot.md | Components / Data Flow / Artifact Contracts / Key Files | absent | present (custom structure) | present (verified observations + architecture fit) |
| request_log.json | request_id / system_id / session_timestamp / inputs_used / files_touched / decisions / open_questions / artifacts_generated | present (canonical fields) | present (reduced: session_id + decisions only) | present (reshaped: repo_state + assessment + verified_observations) |
| session_reasoning_graph.json | session_id / nodes / edges / minimal_path / exploration_branches | absent | present (reduced: nodes + edges + minimal_path) | present (reshaped: per-artifact assessment) |

## Key State Characteristics
- All sessions target `system_id: liveview` or the research hub itself. No cross-system artifacts exist yet.
- Session 1 is the only session where markdown artifacts follow the canonical heading structure.
- Session 3 introduces the richest evidence model but the most divergent structure.
- No session populates the `exploration_branches` field in reasoning graphs.
- Session 3 introduces `analysis_prompt.md`, a non-canonical artifact that captures the interpretation directive.

## Research Artifact Coverage (as of this snapshot)
- Observations: 7 (3 from 2026-03-07, 4 from 2026-03-12 batch, 3 from this analysis)
- Questions: 3 (2 from 2026-03-07, 1 from 2026-03-12 batch, 1 from this analysis)
- Experiments: 1 (from 2026-03-07)
- Snapshots: 2 (from 2026-03-07) + this snapshot
- Synthesis: 3 (2 from 2026-03-07, 1 from 2026-03-12 batch, 1 from this analysis)

## Significance
This snapshot marks the point where the artifact ledger has enough diversity to reveal that producer type, not just schema version, drives structural variation. It is also the point where the research output pipeline has enough artifacts to begin evaluating its own done criteria against the thresholds in `RESEARCH_CONTRACT.md`.
