# Chat Session Artifact Prompt

Paste this into a chat AI at the end of a conversation (or at the start if you want it to capture as you go). Replace the bracketed fields at the bottom.

---

## Prompt

I need you to produce a structured artifact set from this conversation. These artifacts feed a research repository that tracks patterns across AI-assisted development projects.

Produce all 7 artifacts below as a single output. Separate each with a line that reads exactly `--- file: <filename> ---`. Ground every section in what we actually discussed — no filler, no generic content. If a section doesn't apply, write "Nothing observed." rather than inventing something.

### 1. system_snapshot.md

```
# System Snapshot

## Components
(List modules, services, repos, or tools involved in this session.)

## Data Flow
(How data moves through the system: producer → transformation → consumer.)

## Artifact Contracts
(List artifacts produced or referenced in this session.)

## Key Files
(Files that define or constrain the current system state.)
```

### 2. lesson_learned.md

```
# Lesson Learned

## What Happened
(What was the session about? Concrete actions, not narrative.)

## What Worked
(What produced value? Be specific.)

## What Failed
(What didn't work, was abandoned, or surprised you?)

## Reusable Takeaway
(One or two sentences. Portable to a future session.)
```

### 3. complexity_inflection_points.md

```
# Complexity Inflection Points

## Decision Point
(What architectural or design choice was made or considered?)

## Before
(State before the decision.)

## After
(State after, or projected state.)

## Why Complexity Increased or Decreased

## Tradeoffs
(What was gained and what cost or complexity was introduced? Architectural decisions usually involve tradeoffs rather than pure increases or decreases.)

## Trigger Signals
(What would indicate this pattern is recurring?)
```

### 4. strategy_context_reduction.md

```
# Context Reduction Strategy

## Goal
(What were we trying to reduce or clarify?)

## Context Retained
(What matters for next time?)

## Context Removed
(What can be dropped?)

## Result

## Next Step Protocol
(Minimum steps to continue from here.)
```

### 5. research_bridge.md

```
# Research Bridge Artifact

## System
(System identifier, e.g. liveview, or "ad-hoc" if none.)

## Session Focus

## Evidence
(Concrete references only. Examples:)
(- file paths: src/ingest/parser.ts)
(- commands executed: npm run test:ingest)
(- artifact files generated: artifacts/sessions/2026-03-11/lesson_learned.md)
(- schema or contract names: ARTIFACT_SCHEMA.md, SNAPSHOT_CONTRACT.md)
(- UI observations: dashboard renders 16 records with null timestamps visible)
(- architectural decisions: separated ingest from UI layer)
(Avoid vague statements. If no concrete evidence exists, write "No concrete evidence captured.")

## Observed Pattern

## Candidate Observation
(Short enough to seed a standalone research observation.)

## Open Questions
```

### 6. session_reasoning_graph.json

```json
{
  "session_id": "",
  "nodes": [
    {
      "id": "N1",
      "action": "",
      "evidence": [],
      "outcome": "",
      "next": []
    }
  ],
  "edges": [
    { "from": "N1", "to": "N2", "reason": "" }
  ],
  "minimal_path": [],
  "exploration_branches": []
}
```

### 7. request_log.json

```json
{
  "request_id": "",
  "system_id": "",
  "session_timestamp": "",
  "inputs_used": [],
  "files_touched": [],
  "decisions": [],
  "open_questions": [],
  "artifacts_generated": [
    "system_snapshot.md",
    "lesson_learned.md",
    "complexity_inflection_points.md",
    "strategy_context_reduction.md",
    "research_bridge.md",
    "request_log.json",
    "session_reasoning_graph.json"
  ]
}
```

### Session Details

Fill these in before pasting, or let the model infer from conversation:

- **system_id**: [system being discussed, or "ad-hoc"]
- **request_id**: [short label for this session]
- **session_timestamp**: [today's date]

### Output Format

Return the artifacts as a single block with this exact delimiter between each:

```
--- file: system_snapshot.md ---
(content)

--- file: lesson_learned.md ---
(content)

--- file: complexity_inflection_points.md ---
(content)

--- file: strategy_context_reduction.md ---
(content)

--- file: research_bridge.md ---
(content)

--- file: session_reasoning_graph.json ---
(content)

--- file: request_log.json ---
(content)
```
