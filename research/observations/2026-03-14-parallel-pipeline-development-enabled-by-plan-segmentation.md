# Observation

## Title
Parallel pipeline development across repos is enabled by plan segmentation into file-per-story, not by shared context windows

## Context
Operator reflection on the 2026-03-14 session where chatGPT_parser audio pipeline and liveview workbench were built concurrently using different agents in different build cycles.

## Evidence
- `chatGPT_parser/pipeline/audio_stt/` contains 5 stage files (`01_stage_1_transcribe_command.md` through `05_stage_5_validation_and_rollout.md`), each an independent story with acceptance criteria and definition of done.
- `liveview/ui/plans/pipeline/workbench-v2/` contains 6 planning docs (`ARCHITECTURE.md`, `COMPONENT_MAP.md`, `INTERACTION_MODEL.md`, `PHASE_TASKS.md`, `GRAPH_SPIKE.md`, `TESTING_STRATEGY.md`).
- Both plan sets were created in the first hour of the session (chatGPT_parser stages created by 23:57, liveview plans created between 19:35 and 19:45).
- The operator reports using web AI chat (Claude/ChatGPT) for co-architecture and high-level strategy, then refining the plan collaboratively, then segmenting into file-per-story for CLI agent (Codex) execution.
- Both repos produced working, tested implementations within the same session window.

## What Happened
The operator ran a three-phase workflow:
1. **Web chat co-architecture** — high-level objectives and strategy with a conversational AI
2. **Plan refinement** — collaborative plan review and approval with the co-architect
3. **Story segmentation** — plan broken into separate files (one per story/stage), treated as a feature in scrum/agile, then handed to CLI implementation agents

The file-per-story pattern enabled context-switching between repos without losing orientation. When one build cycle completed, the operator could re-read the next story file and refocus quickly without reconstructing the full plan from memory or chat history.

## Why It Matters
This is direct evidence for the dual-loop architecture described in `archStandards/STRATEGY_OVERVIEW.md` — high-entropy (web chat strategy) feeding low-entropy (CLI implementation). But it adds a specific mechanism: **plan segmentation into files** is the bridge that makes dual-loop practical. Without the stage files, context-switching between two concurrent pipelines would require re-reading the full plan or relying on chat history — exactly the failure mode the artifact-driven approach is designed to prevent.

The observation also validates the `ARTIFACT_SCHEMA.md` principle that artifacts should be "readable in isolation." The stage files function as isolated, self-contained work units that don't require the full plan context to execute.

## Short Pattern Explanation
File-per-story plan segmentation converts high-level strategy into context-switchable work units, enabling parallel development across repos with different agents.
