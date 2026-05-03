# System Index

This repo's contracts live at root: ARTIFACT_SCHEMA.md (session artifact shape), RESEARCH_CONTRACT.md (research artifact types), AGENTS.md (agent behavior).

## Systems Referenced

### liveView

system_id: liveview
system_type: implementation
repo_path: D:\work\liveView

description:
Deterministic artifact pipeline with separate ingest and UI layers.
Designed to support multi-model development workflows and structured artifact production.

key_contract_files:
- PROJECT_CONTEXT.md — project structure, architecture, dev guidelines
- SNAPSHOT_CONTRACT.md — snapshot artifact shape and emission rules
- RESEARCH_LINK.md — declares how liveView connects to this research hub

artifact_outputs:
- artifacts/sessions/

research_relationship:
Implementation artifacts generated in this repo may inform:

- research/observations/
- research/experiments/
- research/questions/
- research/snapshots/
- research/synthesis/

notes:
This system is currently the primary experimental platform for testing
architecture patterns around contracts, snapshot artifacts, and
AI-assisted development workflows.

## Observed Systems

Repos under `D:\work` that emit retrospective or lesson-learned artifacts
and are visible to this hub via cross-repo reading, but do not have a
formal contract integration. See
`research/synthesis/2026-05-02-retrospective-pattern-spread-across-systems.md`
for the finding that motivated this section.

These are *one-way visibility* relationships. The hub may read and
synthesize from them; they do not declare a `RESEARCH_LINK.md` and are
not expected to.

| System | Path | Retrospective surface |
|---|---|---|
| chatGPT_parser | `D:\work\chatGPT_parser` | `tmp/research_session_*/lesson_learned.md`; cross-repo partner in 2026-04-10 session |
| writing | `D:\work\writing` | `artifacts/sessions/*/lesson_learned.md` (replicates ARTIFACT_SCHEMA shape) |
| RaidUI | `D:\work\RaidUI` | `docs/retros/phase-N-retro.md`, `docs/retros/session-retro-*.md`, `docs/style-guide/template-retro.md` |
| planning | `D:\work\planning` | `docs/session-retro-*.md`, `docs/adr/adr-007-qa-as-postmortem.md` |
| planning-runtime | `D:\work\planning-runtime` | `runs/run-*/qa-retro.md` (per-run retros) |
| start/precheck | `D:\work\start\precheck` | `docs/retrospective-*.md`, `docs/system-foundation-v2/adr/009-lesson-lifecycle-over-binary-toggle.md` |
| start/precheckv2 | `D:\work\start\precheckv2` | mirrors precheck's retrospective and ADR set |
| start/planner | `D:\work\start\planner` | `docs/ai-retrospective-findings.md` (curated 12-source external research) |
| start/contextforge | `D:\work\start\contextforge` | `docs/retrospective-*.md` |
| start/ashley | `D:\work\start\ashley` | `docs/retrospective-*.md` |
| game | `D:\work\game` | `docs/retro-*.md`, `docs/retrospective-*.md` |
| archStandards | `D:\work\archStandards` | `lessons-learned-*.md` |
| www | `D:\work\www` | `retrospective-*.md` |

Promotion criteria from observed → contracted (proposed, not yet adopted):
1. The system declares a `RESEARCH_LINK.md` describing its emission contract.
2. Its retro/lesson artifact shape conforms to or extends `ARTIFACT_SCHEMA.md`.
3. There is a recurring research interest in synthesizing across that system's output.
