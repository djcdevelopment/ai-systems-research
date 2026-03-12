# Start Here

This is a research hub. It observes AI-assisted development projects and captures structured artifacts for later analysis.

## Last Session
Check the last entry in `SESSION_LOG.jsonl`.

## Two Artifact Tracks

**Track 1 — Engineering Telemetry:** Implementation repos (see `SYSTEM_INDEX.md`) emit session artifacts automatically into `artifacts/sessions/`.

**Track 2 — Observational / Ad-Hoc:** Conversations and manual sessions produce the same artifact shape via `CHAT_SESSION_PROMPT.md`.

Both tracks feed `research/{observations,experiments,questions,snapshots,synthesis}/`.

## Starting an Ad-Hoc Session
1. Open `CHAT_SESSION_PROMPT.md`
2. Paste into your chat AI with your session context
3. Place output in `artifacts/sessions/<session-name>/`
4. Append an entry to `SESSION_LOG.jsonl`
5. Commit when the artifact set is stable

## Contracts
See `SYSTEM_INDEX.md` for all contracts — this repo and external systems.
