# Manifest Link — The Next-Generation Surface

*ai-systems-research/ · pointer · 2026-05-22 · closes the recursive loop. This repository is the proto-registry. The next-generation surface — a formal constellation-manifest framework — lives at `D:\work\gad\pm\manifest\`. This document points there, names what was preserved, and names what's new.*

## What this repository is, retrospectively

`ai-systems-research` is the **working registry** for Derek's multi-repo AI development ecosystem. From 2026-03-11 through present, it has been:

- The home of `ARTIFACT_SCHEMA.md` — the canonical multi-artifact schema (`canonical`/`extended`/`reduced` conformance levels).
- The producer of `SESSION_LOG.jsonl` — per-session ledger with structured fields.
- The home of `research/snapshots/` — periodic snapshots of the ecosystem's state, with `Producer Type | Conformance` columns naming the working vocabulary.
- The home of `analysis/cross_repo_analysis.md` — the proto-dashboard observing the multi-repo ecosystem.
- The home of `analysis/<repo>_analysis.md` — per-repo summary docs.
- The home of `CHAT_BOOTSTRAP.md` — the proto-manifest, naming the 4-repo ecosystem and the producer/consumer arrows.
- The home of `runs/<date>-cross-repo-delta/` — cross-repo file-modification tracking with evidence CSVs.

In the language of `archStandards/STRATEGY_OVERVIEW.md`: this repo was the *implementation surface* for "**Artifacts as Context Waypoints. Artifacts are the 'shared memory' between me and the agents.**"

## What the next-generation surface is

A formal constellation-manifest framework, planned across six documents at `D:\work\gad\pm\manifest\`:

| Document | Purpose |
|---|---|
| `MANIFEST-SCHEMA.md` | Declarative YAML format for a constellation manifest |
| `ENROLLMENT-WORKFLOW.md` | 9-step cold-start workflow |
| `MAF-WORKFLOW.md` | Microsoft Agent Framework agent topology + Pydantic AI bolt-on for contract enforcement |
| `ARCHITECTURE-REVIEW.md` | Three-layer review + MIT-prof critique pass + four corrections |
| `SCHEMA-EXTENSIONS-v1.md` | Discovery mode + field restorations + Pydantic model definitions |
| `LINEAGE.md` | The chronology — including this repository's role |
| `RELATED-WORK.md` | Position against LangGraph, Dapr Agents, AWS Strands, Pydantic AI, Temporal, Pulumi, Terraform, Renovate, BDI, OpenAPI, W3C PROV |
| `VALIDATION.md` | Success metrics + falsifiability conditions for the framework |
| `PICKUP-NOTE.md` | Resumption point for Claude/Derek on next session |

The framework is **planning-grade** as of 2026-05-22; no code ships yet. The implementation surface is Python + MAF + Pydantic AI + OpenTelemetry, with `FileCheckpointStorage` for solo-operator state.

## What's preserved from this repository

The framework explicitly carries forward, by name:

- **`Producer Type`** as a typed enum field (`producer_type` in the schema) — seeded with values from `research/snapshots/2026-03-14-six-session-two-system-artifact-ledger-state.md` (`human narrative`, `human+AI protocol`, `AI analysis`, `AI code analysis`, `AI cross-repo analysis`), normalized to producer-role vocabulary.
- **`Conformance`** as a graceful-degradation enum (`canonical`/`extended`/`reduced`/`non-canonical`) — including the honest `non-canonical (custom structure)` value preserved as a first-class option.
- **The four-noun model** (Evidence / Artifacts / Projections / Contracts) from `plans/research/current_architecture_overview.md` lines 289-355.
- **Producer/consumer relationships as first-class** — the `contracts:` block in the manifest is the formalization of *"repositories that share a contract"* from `synthesis/cross_repo_synthesis.md`.
- **The doctrine** from line 474 of `current_architecture_overview.md`: *"This is a normal maturation point. The challenge now is not to reduce ambition. The challenge is to convert emergent patterns into declared architecture."* — this is the framework's animating purpose.
- **The Dual-Loop framing** from `STRATEGY_OVERVIEW.md` — the framework recognizes both the strategic loop (operator-in-Discord-and-drafting) and the implementation loop (MAF executors), and honors the strategic loop without scheduling it.
- **The `SCHEMA_VERSION` + schema-as-code discipline** from `ai-dev-system/src/contracts.py` (2026-03-11) — preserved as the framework's Design Principle #8 (YAML + Pydantic synced by build).

The framework's `SCHEMA-EXTENSIONS-v1.md` has a 17-row field-by-field map crediting this repository (and `ai-dev-system`, `archStandards`, `liveview`, `chatGPT_parser`) by absolute path and date. Every load-bearing field in the new framework traces back somewhere in the precursor.

## What's new in the next-generation surface

The framework adds eight things that don't exist in this repository:

1. **Discord-as-PM-channel as first-class.** Tonight's `archetype: presence` constellations get a Discord saga thread + bridge to ADO. No precedent here.
2. **ADO + GitHub identity decoupling.** The 2026-05-20 decision (`djcdevelopment` for code; `steppeintegrations` for ADO). New.
3. **Microsoft Agent Framework (MAF) as the execution substrate.** MAF 1.0 GA shipped 2026-04-03; Python 1.6.0 on 2026-05-22. New.
4. **Pydantic AI as the contract-enforcement bolt-on.** `pydantic-ai==1.101.0` with `output_type` + `retries=3`. The role it plays — making the latent typed contracts in this repository explicit and machine-checkable — is faithful to the lineage, but the tool is new.
5. **Discovery mode as a workflow primitive.** This repository *practiced* discovery (the registry catching up to the work); the framework now *codifies* discovery as an executable mode with a 9-source cascade of signals + Pydantic-AI-typed inference.
6. **The 30-minute first-run enrollment target.** Honest pacing made measurable.
7. **The "cognitive snapshot for a solo operator on 7-12 things" sizing.** Operational specificity not present in the precursor.
8. **The democratization thesis as design discipline** — enterprise-grade tooling at solo-prosumer-with-GPU scale, named explicitly across the framework's docs.

## What this means for future agents reading this repository

If you arrive at `D:\work\ai-systems-research\` and you're working on this constellation:

- **Read this document first** to understand that the registry pattern continues in a more formal home.
- **Read `D:\work\gad\pm\manifest\LINEAGE.md`** for the full chronology — including this repository's role across nine timestamped milestones.
- **Read `D:\work\gad\pm\manifest\SCHEMA-EXTENSIONS-v1.md` §4** for a worked example of what a discovery-mode enrollment of *this very repository* would produce — including the proposed `constellation.yaml` for ai-systems-research.
- **Treat this repository as a precursor in active use**, not a deprecated archive. The framework expects to *enroll* this constellation (it's the first adoption target per `pm/manifest/PICKUP-NOTE.md` decisions list).

## The recursion, named

This document is itself an artifact under this repository's own protocol. The framework that points back to ai-systems-research is using ai-systems-research's protocol to do the pointing. The pattern observes itself observing itself.

In the language of `ai-dev-system/docs/Build_memo_Arifact_engine.md` (2026-03-11):

> *"The project is no longer just tooling for AI workflows. It is evolving into a system for capturing work, reasoning about it, and compounding that reasoning into future leverage."*

The next-generation surface at `D:\work\gad\pm\manifest\` is that compounding, made formal and made portable.

*source: manifest-link · produced_at: 2026-05-22 · framework_version: pre-1.0 · constellation: ai-systems-research · schema_version: 1*
