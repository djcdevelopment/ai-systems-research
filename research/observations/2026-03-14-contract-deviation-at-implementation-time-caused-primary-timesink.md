# Observation

## Title
Deviating from the planned contract at implementation time caused the primary timesink despite high overall velocity

## Context
Operator reflection on the 2026-03-14 audio STT pipeline build. The session produced ~3,500 lines of implementation with 106 passing tests, but the dominant time cost was debugging a contract gap introduced by pivoting from the planned approach mid-implementation.

## Evidence
- The audio STT plan (`pipeline/audio_stt/`) defined a 5-stage pipeline starting with API-first transcription (Stage 1: `transcribe-audio` command using OpenAI API).
- The operator pivoted to local model execution (`local-whisper` / `faster-whisper`) before the API-first approach was fully exercised, deviating from the planned stage sequence.
- `docs/AUDIO_STT_STATUS_2026-03-13.md` documents the GPU debugging: missing `cublas64_12.dll`, CUDA runtime library issues, pip setup for `faster-whisper`.
- The plan's Stage 2 (`02_stage_2_sidecar_contract_and_linkage.md`) explicitly defines the sidecar contract — but no stage defined the contract for what a local model provider connection would look like (model loading, device selection, compute type, worker parallelism).
- The operator reports that because the local provider integration was generated at implementation time without a pre-defined contract, naming conventions had to be traced from runtime smoke test failures rather than from a specification.
- The final implementation shows the provider abstraction in `audio_transcribe.py:build_transcriber()` — a 2-branch factory (`openai` vs `local-whisper`) with `make_faster_whisper_transcriber()` accepting `device` and `compute_type` — emerged from debugging, not from upfront design.

## What Happened
The plan correctly anticipated the transcription command, sidecar contract, operational controls, and provider integration as separate stages. But when the operator pivoted to local execution before completing the API-first path, the implementation entered territory where no contract existed. The code generation agent produced working code, but the naming and structure had to be discovered through runtime failures rather than validated against a specification.

The GPU/pip debugging was "straightforward to solve" (operator's words). The actual timesink was the contract gap: tracing naming mismatches in generated code when the provider interface wasn't pre-specified.

## Why It Matters
This is a concrete counterexample to the session's dominant pattern of high velocity. The same session that produced ~3,500 lines of tested code also demonstrated that deviating from a defined contract — even within a single repo — creates debugging friction disproportionate to the amount of code involved.

The observation supports two candidate claims:
1. Contract-aligned implementation velocity is dramatically higher than contract-absent implementation velocity, even when the total code output is similar.
2. The plan segmentation pattern (file-per-story) works as a velocity multiplier only when the stories actually cover the territory being implemented. Unplanned pivots bypass the story structure entirely.

This also connects to the cross-repo synthesis: if a missing provider contract within a single repo causes meaningful debugging friction, the missing cross-repo projection contract (catalog not committed, no cross-repo test) is a larger version of the same risk.

## Short Pattern Explanation
Planned contract → high velocity. Mid-implementation deviation without contract → dominant timesink. The ratio of productivity to friction is governed by contract coverage, not by coding speed or agent capability.
