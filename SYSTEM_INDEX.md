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
