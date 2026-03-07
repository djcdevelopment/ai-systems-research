# AGENTS.md

## Repo Role
This repository is the research hub.

Its job is to:
- interpret source-system artifacts
- preserve observations, experiments, questions, snapshots, and synthesis
- support exploratory reasoning across systems
- improve the research set over time

It is **not** the primary place for implementation changes.

## Primary Contracts
Read and obey these files first when relevant:

- RESEARCH_CONTRACT.md
- ARTIFACT_SCHEMA.md
- SYSTEM_INDEX.md

Use these as authoritative definitions for artifact structure, system identity, and handoff expectations.

## Source Systems
Implementation repositories are source systems.
They produce operational artifacts.
This repository interprets those artifacts.

Always prefer evidence from:
- implementation session artifacts
- contract files
- test outputs
- repo structure
- snapshots
- recorded decisions

## Artifact Rules
When producing research artifacts, use the structures defined in RESEARCH_CONTRACT.md.

Primary artifact destinations:

- research/observations/
- research/experiments/
- research/questions/
- research/snapshots/
- research/synthesis/

## Research Standards
Prefer:
- evidence-first writing
- explicit uncertainty
- provisional claims
- stable system identifiers
- multiple possible interpretations when warranted

Avoid:
- polished article prose unless explicitly requested
- overstated generalization
- unsupported claims
- collapsing evidence and interpretation into one section

## Cross-Repo Behavior
When referencing a source system:
- use its system_id
- name concrete files and artifacts when available
- keep the handoff traceable

## Default Session Goal
When no better instruction is given:
1. inspect current research state
2. inspect relevant source-system evidence
3. improve one or more research artifacts
4. preserve optionality for later synthesis
