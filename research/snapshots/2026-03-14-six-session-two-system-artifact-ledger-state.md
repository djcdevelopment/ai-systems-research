# Snapshot

## Title
Artifact ledger state at six sessions across two systems

## Date
2026-03-14

## Scope
All artifacts under `artifacts/sessions/` and `research/` as of this snapshot.

## Sessions

| Session | Date | System | Artifacts | Producer Type | Conformance |
|---|---|---|---|---|---|
| 2026-03-09-conversation-ledger | 2026-03-09 | liveview | 5 (4 md + 1 json) | human narrative | canonical (reduced) |
| 2026-03-11-chat-artifact-protocol | 2026-03-11 | research-hub | 7 (5 md + 2 json) | human+AI protocol | extended (divergent headings) |
| 2026-03-11-liveview-observability-research | 2026-03-11 | liveview | 7 (5 md + 2 json) | AI analysis | extended |
| 2026-03-11-liveview-ui | 2026-03-11 | liveview | 8 (6 md + 2 json) | AI code analysis | extended (divergent structure) |
| 2026-03-13-chatgpt-parser-contract-research | 2026-03-13 | chatgpt_parser | 7 (5 md + 1 json + 1 prompt) | AI cross-repo analysis | extended |
| 2026-03-13-chatgpt-parser-assessment | 2026-03-13 | chatgpt_parser | 6 (5 md + 1 prompt) | AI integration assessment | non-canonical (custom structure) |

## Changes since last snapshot (2026-03-12)

- **2 new sessions** covering chatGPT_parser as a system (first non-liveview sessions)
- **Second system registered**: chatgpt_parser joins liveview as an observed system
- **New session structure**: The 2026-03-13-chatgpt-parser-assessment session uses `integration_assessment.md`, `next_steps.md`, and `open_questions.md` — none of which are defined in `ARTIFACT_SCHEMA.md`. This is the most structurally divergent session yet.
- **Producer type 4 emerges**: AI performing cross-repo integration assessment, citing evidence from multiple repos simultaneously. Previous producer types operated within a single repo's context.

## Research Artifact Coverage

| Category | Count | Sources |
|---|---|---|
| Observations | 13 | 3 (2026-03-07), 4 (2026-03-11), 4 (2026-03-12), 2 (2026-03-14) |
| Questions | 5 | 2 (2026-03-07), 1 (2026-03-11), 2 (2026-03-12) |
| Experiments | 1 | 1 (2026-03-07) |
| Snapshots | 4 | 2 (2026-03-07), 1 (2026-03-12), 1 (2026-03-14) |
| Synthesis | 7 | 2 (2026-03-07), 2 (2026-03-11), 2 (2026-03-12), 1 (2026-03-14) |

## Done Criteria Check (per RESEARCH_CONTRACT.md)

For an article-ready topic, need: 3+ observations, 1+ experiment, 1+ snapshot, 1+ meaningful question, enough evidence for 2-3 candidate claims.

**Topic: "Producer diversity and contract evolution in artifact-driven development"**
- Observations: 13 (exceeds threshold)
- Experiments: 1 (meets threshold)
- Snapshots: 4 (exceeds threshold)
- Questions: 5 (exceeds threshold)
- Candidate claims: at least 5 across existing synthesis artifacts

**Assessment: This topic meets done criteria for article readiness.**

## Significance
This snapshot marks two transitions: (1) the ecosystem now has multi-system coverage (liveview + chatgpt_parser), and (2) the chatgpt-parser-assessment session's non-canonical structure is the strongest evidence yet that the session artifact schema needs either enforcement or explicit extension points. The schema is being stretched by use, not by design.
