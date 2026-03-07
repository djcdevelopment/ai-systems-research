# Artifact Schema

## Purpose

This file defines the canonical schema for implementation-session artifacts that may be produced by source repositories and consumed by the research repository.

These artifacts are intended to be:
- deterministic
- low-context
- easy to parse by humans or models
- stable across sessions

Artifacts should prefer explicit sections over narrative flow.

## Source Context

Primary source systems may emit artifacts into local paths such as:

- artifacts/sessions/<timestamp>/

These artifacts may later be referenced by research artifacts in:

- research/observations/
- research/experiments/
- research/questions/
- research/snapshots/
- research/synthesis/

## General Rules

1. Use stable headings exactly as defined below.
2. Keep content concrete and grounded in repository reality.
3. Separate facts from interpretation.
4. Avoid filler prose.
5. Prefer bullet points where possible.
6. If something is unknown, say so explicitly.
7. Include file paths, tests, modules, and outputs when available.

---

## Schema: lesson_learned.md

### Required Path
- artifacts/sessions/<timestamp>/lesson_learned.md

### Required Structure

# Lesson Learned

## What Happened

## What Worked

## What Failed

## Reusable Takeaway

### Notes
- Focus on session-level implementation learning.
- Reusable takeaway should be short and portable.

---

## Schema: complexity_inflection_points.md

### Required Path
- artifacts/sessions/<timestamp>/complexity_inflection_points.md

### Required Structure

# Complexity Inflection Points

## Decision Point

## Before

## After

## Why Complexity Increased or Decreased

## Trigger Signals

### Notes
- Focus on architecture and interface changes.
- Trigger signals should help detect similar issues in future sessions.

---

## Schema: strategy_context_reduction.md

### Required Path
- artifacts/sessions/<timestamp>/strategy_context_reduction.md

### Required Structure

# Context Reduction Strategy

## Goal

## Context Retained

## Context Removed

## Result

## Next Step Protocol

### Notes
- This artifact documents how context was compressed for effective execution.
- Next Step Protocol should describe the minimum viable context for repeating the task.

---

## Schema: research_bridge.md

### Required Path
- artifacts/sessions/<timestamp>/research_bridge.md

### Required Structure

# Research Bridge Artifact

## System

## Session Focus

## Evidence

## Observed Pattern

## Candidate Observation

## Open Questions

### Notes
- This artifact is the preferred bridge from implementation sessions into the research repo.
- Candidate Observation should be short enough to seed an observation artifact.

---

## Schema: request_log.json

### Required Path
- artifacts/sessions/<timestamp>/request_log.json

### Required JSON Shape

{
  "request_id": "string",
  "system_id": "string",
  "session_timestamp": "string",
  "inputs_used": [],
  "files_touched": [],
  "decisions": [],
  "open_questions": [],
  "artifacts_generated": []
}

### Field Meanings

- request_id: unique identifier for the task/request
- system_id: canonical system key, e.g. liveview
- session_timestamp: timestamp or session identifier
- inputs_used: files, prompts, or artifacts used
- files_touched: implementation files changed or inspected
- decisions: key implementation or architecture decisions
- open_questions: unresolved questions after the task
- artifacts_generated: emitted artifact file paths

---

## Recommended Session Folder Shape

artifacts/
  sessions/
    <timestamp>/
      lesson_learned.md
      complexity_inflection_points.md
      strategy_context_reduction.md
      research_bridge.md
      request_log.json

---

## Validation Heuristics

An artifact is valid if:

- it uses the expected filename
- it uses the expected headings or JSON fields
- it is grounded in the actual session
- it can be read in isolation
- it can be ingested by a downstream synthesis workflow

An artifact is weak if:

- it is vague
- it merges multiple concerns without structure
- it contains unsupported conclusions
- it requires hidden conversation context to understand

---

## Design Principle

Implementation systems produce operational artifacts.
Research systems interpret those artifacts.

This schema exists to keep that handoff explicit, stable, and reusable.
