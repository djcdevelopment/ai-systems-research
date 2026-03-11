# AI Systems Research

Artifact-driven research repository for capturing, indexing, and analyzing AI-assisted engineering sessions.

This repository is the **research loop** side of the broader system.

It is designed to reduce cold-start cost, preserve reasoning context, and accumulate structured evidence across sessions without relying on memory or chat history.

---

## What this repository does

This repo stores and organizes structured session artifacts produced from engineering work, architectural exploration, and AI-assisted collaboration.

The goal is to make sessions:

- resumable
- discoverable
- comparable
- analyzable later

This repository is not the implementation system itself.  
It is the place where implementation artifacts and session artifacts become durable research inputs.

---

## Current milestone

This commit establishes the first lightweight **session restart and discoverability layer**.

It adds:

- START_HERE.md
- SESSION_LOG.jsonl
- session_reasoning_graph.json as a first-class session artifact
- updated ARTIFACT_SCHEMA.md
- updated CHAT_SESSION_PROMPT.md

This milestone is focused on one core problem:

**re-entry after context switching**

When returning to the repository after hours or days away, the operator should be able to understand:

- what happened last
- what artifacts were produced
- what open threads remain
- where to continue

without manual repo archaeology.

---

## Core design idea

The repository operates as part of a dual-loop architecture.

### Implementation Loop
Produces deterministic outputs from real work:
- code
- tests
- manifests
- logs
- snapshots

### Research Loop
Captures structured artifacts about the work:
- system snapshots
- lessons learned
- complexity inflection points
- context reduction strategies
- research bridge artifacts
- request logs
- reasoning graphs

Artifacts are the boundary between these loops.

---

## New infrastructure added in this milestone

### 1. START_HERE.md
A short landing page for repo re-entry.

Purpose:
- orient the operator quickly
- explain what this repo is
- explain where to look first
- point to contracts and session workflow

This file is intentionally short.
Its job is orientation, not exhaustive explanation.

---

### 2. SESSION_LOG.jsonl
Append-only session index at repo root.

Each line represents one session and includes fields such as:
- session_id
- 	imestamp
- system_id
- status
- summary
- rtifacts
- open_threads
- easoning_graph

Purpose:
- eliminate directory scanning on restart
- make latest session obvious
- preserve unfinished threads explicitly
- support future cross-session analysis

This is intentionally JSONL instead of a large JSON array so entries can be appended cheaply and safely.

---

### 3. session_reasoning_graph.json
New session artifact type.

This artifact captures the reasoning topology of a session, including:
- reasoning nodes
- dependency edges
- minimal path
- exploration branches

Purpose:
- preserve how conclusions were reached
- make exploration vs convergence visible
- enable future operator observability and reasoning-efficiency analysis

This artifact is intended to support later research passes without requiring additional logging infrastructure.

---

### 4. ARTIFACT_SCHEMA.md
Updated to include:
- system_snapshot.md
- session_reasoning_graph.json

Purpose:
- keep the session artifact contract canonical
- ensure future artifact producers remain aligned

---

### 5. CHAT_SESSION_PROMPT.md
Updated to emit the expanded artifact set.

This prompt now produces a fuller session package that can be dropped into the research repo with minimal cleanup.

Purpose:
- standardize chat-to-artifact conversion
- reduce manual summarization overhead
- improve portability between AI sessions

---

## Session artifact set

A session folder now contains:

    artifacts/sessions/<session-name>/
        system_snapshot.md
        lesson_learned.md
        complexity_inflection_points.md
        strategy_context_reduction.md
        research_bridge.md
        request_log.json
        session_reasoning_graph.json

These artifacts are designed to be:
- grounded
- reusable
- machine-readable where helpful
- useful to both operator and later research passes

---

## Restart workflow

The intended cold-start workflow is now:

1. Open START_HERE.md
2. Read the latest line in SESSION_LOG.jsonl
3. Inspect open_threads
4. Open the referenced session artifact folder
5. Continue work or begin a new session

This reduces restart cost to reading two small files instead of rediscovering the repository manually.

---

## Why this matters

This repository is meant to capture more than project state.

It captures:
- architectural decisions
- complexity inflection points
- context reduction strategies
- reasoning flow
- operator workflow signals

Over time, this enables analysis of:
- recurring complexity patterns
- repeated architectural decisions
- reasoning efficiency trends
- discoverability failures
- workflow drift

The artifacts are the data.
Research passes are later reads across those artifacts.

---

## Relationship to other repos

This repository is intended to work with implementation repos and observability tools such as:

- producer systems that emit artifacts
- ingest systems that normalize outputs
- UI systems that visualize artifacts and runs

Typical broader flow:

    implementation repo
        -> emits artifacts

    research repo
        -> stores and indexes session artifacts

    ingest / UI layers
        -> visualize and analyze the resulting data

---

## Practical note

This repository is still taking shape.

Breadcrumbs matter while the system is evolving.

This README exists to capture the purpose of this milestone so that future sessions do not need to reconstruct why these files were added.

---

## Status

This commit represents the first stable version of the **session restart and discoverability layer** for the research loop.

Recommended next steps after this milestone:
- visualize reasoning graphs
- compare sessions through the session log
- add lightweight query / aggregation scripts
- continue refining artifact-driven operator observability

