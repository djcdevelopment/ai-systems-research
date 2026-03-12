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

## Session Package Contract

### Canonical Handoff Boundary

- `package-research-session.ps1` is the canonical boundary for packaging reflective session artifacts into `artifacts/sessions/<timestamp>/` and emitting the corresponding `SESSION_LOG.jsonl` entry.
- `liveview/ingest` operational artifacts and `ai-systems-research` session packages remain separate layers. This schema only defines the research/session package side of the handoff.

### Required Artifacts

The current minimum packageable set is the markdown session package enforced by `package-research-session.ps1`:

- `lesson_learned.md`
- `complexity_inflection_points.md`
- `strategy_context_reduction.md`
- `research_bridge.md`
- `system_snapshot.md`

### Optional Artifacts

Optional artifacts may be present in a valid session package, but are not required for package validity:

- `request_log.json`
- `session_reasoning_graph.json`
- `analysis_prompt.md`

### Packaging-Emitted Metadata

Each `SESSION_LOG.jsonl` entry emitted by the packaging script should include:

- `session_id`
- `timestamp`
- `system_id`
- `status`
- `summary`
- `open_threads`
- `artifacts`
- `conformance`

### Conformance Levels

- `canonical`: all required artifacts are present and no optional artifacts are needed for validity.
- `extended`: all required artifacts are present and one or more optional artifacts are included.
- `reduced`: intentionally incomplete package. This level is documented for legacy or explicitly supported partial bundles; it is not accepted by the current packaging script.

### Timestamp Rule

- New `SESSION_LOG.jsonl` entries emitted by the packaging script should use ISO 8601 UTC timestamps.
- Existing ledger entries may still be date-only. Consumers should remain backward-tolerant while the ledger transitions to UTC timestamps.

### Legacy Note

- Older session folders in this repository include at least one reduced package without `system_snapshot.md`.
- That legacy evidence does not change the current package contract: `system_snapshot.md` remains required for canonical packaging.

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

## Schema: system_snapshot.md

### Required Path
- artifacts/sessions/<timestamp>/system_snapshot.md

### Required Structure

# System Snapshot

## Components
(Modules, services, repos, or tools involved in this session.)

## Data Flow
(Producer → transformation → consumer.)

## Artifact Contracts
(Artifacts produced or referenced in this session.)

## Key Files
(Files that define or constrain current system state.)

### Notes
- Captures system context at session time.
- Helps downstream analysis interpret other artifacts without requiring repo exploration.
- Required for current canonical and extended session packages.

---

## Schema: session_reasoning_graph.json

### Optional Path
- artifacts/sessions/<timestamp>/session_reasoning_graph.json

### Required JSON Shape

{
  "session_id": "string",
  "nodes": [
    {
      "id": "string",
      "action": "string",
      "evidence": [],
      "outcome": "string",
      "next": []
    }
  ],
  "edges": [
    { "from": "string", "to": "string", "reason": "string" }
  ],
  "minimal_path": [],
  "exploration_branches": []
}

### Field Meanings

- session_id: matches the parent session folder name
- nodes: ordered reasoning steps with evidence and outcomes
- edges: directed connections between nodes with reasons
- minimal_path: smallest node sequence that reproduces the session outcome
- exploration_branches: node sequences that were exploratory or redundant

### Notes
- Enables operator observability without additional manual logging.
- Supports future cross-session pattern analysis (reasoning efficiency, recurring discovery branches).
- Optional extension artifact for an otherwise valid package.

---

## Schema: request_log.json

### Optional Path
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

### Notes
- Optional extension artifact for an otherwise valid package.

---

## Schema: analysis_prompt.md

### Optional Path
- artifacts/sessions/<timestamp>/analysis_prompt.md

### Expected Structure

- Prompt or instruction artifact used to generate or evaluate the session package.
- May include task framing, output requirements, evaluation criteria, or explicit claims to verify.

### Notes
- Optional meta-artifact.
- Preserve when it materially explains how the rest of the package was produced.

---

## Recommended Session Folder Shape

artifacts/
  sessions/
    <timestamp>/
      lesson_learned.md
      complexity_inflection_points.md
      strategy_context_reduction.md
      research_bridge.md
      system_snapshot.md
      [optional] request_log.json
      [optional] session_reasoning_graph.json
      [optional] analysis_prompt.md

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
