# Current Architecture Overview

## Purpose of this document

This document defines the current architecture of the ecosystem spanning `ai-dev-system`, `ai-systems-research`, `liveView`, and `chatGPT_parser`.

It exists to make the current system legible, establish official heads-and-tails for ad hoc contracts that emerged through iterative building, and provide a shared source of truth for future planning, implementation, and repo boundary decisions.

This is not a final theory-of-everything document. It is a current-state architecture overview: a practical description of what the system is, why it exists, how the repositories relate, and where the contract boundaries appear today.

---

## Executive summary

What exists today is not a collection of unrelated repos. It is an ecosystem for turning loosely coupled engineering and cognitive activity into deterministic artifacts that can be inspected, analyzed, projected, and reused.

The architecture did not begin from a fully specified top-down design. It emerged through several adjacent efforts:

1. building infrastructure to trace and debug agent orchestration,
2. creating contract-shaped outputs to make that work legible,
3. noticing those contract files enabled deterministic artifact creation,
4. discovering those artifacts could themselves become inputs to meta-analysis,
5. expanding the model to include engineering telemetry and external corpora,
6. building UI surfaces to inspect contract consistency, lineage, and composition.

The result is an ecosystem where **artifacts are the stable interoperability layer**.

Execution systems, telemetry ingest systems, research synthesis systems, and external corpus parsers all either produce or consume artifact-shaped outputs. The repos are different not because they are disconnected, but because they occupy different roles around the same contract surface.

---

## Core architectural thesis

The most important architectural fact is this:

**The system is organized around artifacts and contract surfaces, not around a single runtime or application boundary.**

That distinction matters.

A conventional application often has a single dominant flow such as:

- request
- business logic
- persistence
- UI

This ecosystem is different. It is closer to a layered knowledge-and-observability architecture in which many sources of activity are normalized into durable, inspectable structures.

The central pattern is:

1. some activity happens,
2. evidence of that activity is captured or normalized,
3. deterministic artifacts are created from that evidence,
4. projections/read models are derived for specialized use,
5. those outputs are inspected for completeness, consistency, and lineage,
6. the resulting understanding feeds back into system design and execution.

In this model, artifacts are not incidental output files. They are the durable interface through which loosely coupled systems become interoperable.

---

## The system loop

The overall ecosystem can be understood as the following loop:

```text
activity (agents / humans / telemetry / corpora)
        ↓
evidence capture and normalization
        ↓
artifact creation
        ↓
projection surfaces and read models
        ↓
contract inspection and research synthesis
        ↓
system refinement and better future activity
```

This loop is the real end-to-end.

The system is therefore not best described as a parser, a UI, or an agent harness. It is an architecture for:

- capturing activity,
- preserving it as structured evidence,
- converting it into deterministic artifacts,
- deriving higher-order views,
- and using those views to debug both machine behavior and human/system understanding.

---

## Why the architecture felt unclear

The architecture feels unusual because it grew **from the middle outward**.

The system did not begin with a single formal platform boundary and then split cleanly into services. Instead, it appears to have evolved like this:

- first, a need to trace and debug agent orchestration,
- then, the use of contract-shaped files to make runtime behavior legible,
- then, the realization that the same contract files could be used to generate deterministic artifacts,
- then, the realization that those artifacts could support meta-artifacts and research sessions,
- then, the extension of the same pattern to telemetry streams and external corpora,
- then, the construction of visual inspection surfaces for contract drift and artifact composition.

Because the artifact layer became powerful before the full repo topology was formally named, the system now has multiple valid entrypoints and multiple producer types. That can look blurry from inside the codebase even when the overall shape is coherent.

This is not failure. It is a normal transition point in exploratory architecture: capability surface has outpaced declared contract surface.

---

## Canonical architecture roles

The current ecosystem is best understood as four primary roles.

### 1. Execution / Decision Surface
**Repo:** `ai-dev-system`

This repository functions as a local agentic harness created to help understand and debug decisions made during active work.

Its purpose is to make agent behavior inspectable while work is occurring or immediately after it occurs.

Typical concerns of this role include:

- agent orchestration,
- request/response traces,
- decision visibility,
- execution manifests,
- debugging active runs,
- understanding why an agent chose a path.

This role is fundamentally about runtime evidence.

It answers questions such as:

- What did the agent do?
- What sequence of actions occurred?
- What inputs and decisions produced this outcome?
- Where did the reasoning or orchestration diverge from expectation?

This layer is a **producer of runtime evidence**.

---

### 2. Artifact Synthesis / Meta-Analysis
**Repo:** `ai-systems-research`

This repository began as a side project after noticing how well contract files enable deterministic artifact creation. From that starting point, it grew into a system for meta-artifacts and research-oriented interpretation.

Its role is to transform evidence, work deltas, and observed outputs into durable, structured artifacts and research sessions.

Typical outputs in this role may include:

- lesson artifacts,
- system snapshots,
- research bridge documents,
- reasoning graphs,
- analysis prompts,
- session summaries,
- higher-order artifacts describing patterns across sessions.

This repository is the clearest expression of the idea that artifacts can become first-class inputs to new artifacts.

It answers questions such as:

- What was learned?
- What patterns are emerging?
- What should be preserved as durable system knowledge?
- What higher-order structures can be derived from repeated artifact creation?

This layer is a **consumer of evidence and a producer of deterministic artifacts and meta-artifacts**.

---

### 3. Observability / Contract Inspection
**Repo:** `liveView`

`liveView` contains two highly significant elements:

1. a robust ingest side focused on gathering engineering telemetry,
2. a UI that acts as a close read-model/contract-handoff surface.

The ingest portion was the first major build-out: the nervous system for engineering telemetry.

The UI is not best understood as a conventional product interface. It is more accurately described as a visual debugger for contract inconsistency and system state.

In practice, it appears to function as:

- a read-model surface over canonical outputs,
- a contract inspection layer,
- a lineage viewer,
- an artifact composition debugger,
- a system creativity surface that helps make latent patterns visible.

Because the UI maps closely to view models or handoff contracts, it is effectively a 1:1 or near-1:1 visualization of contract state.

It answers questions such as:

- What exists?
- What is missing?
- What artifacts are required vs optional?
- Where are contract mismatches occurring?
- How do sessions relate?
- What coverage exists and where are gaps?

This layer is primarily a **consumer of projections/read models and a visual debugger for contract consistency**.

---

### 4. External Corpus Ingestion
**Repo:** `chatGPT_parser`

This repository was designed as a standalone project to convert GPT web chat export data into a form with many uses, one of which is projecting surfaces for artifact analysis.

Its purpose is not merely “parse some exports.” Its more meaningful role is to turn a large external conversational corpus into normalized evidence and projection surfaces that can enter the same artifact ecosystem.

This makes it a new producer type: an external corpus ingester.

Likely concerns of this role include:

- corpus normalization,
- message/session/source modeling,
- multimodal sidecar indexing,
- graph construction,
- projection generation,
- preparation of artifact-creation surfaces from conversational data.

It answers questions such as:

- What happened in this external cognitive corpus?
- How can that corpus be represented in durable structured form?
- What projection surfaces make analysis or artifact creation possible?
- How can a large conversation history become inspectable and reusable?

This layer is a **producer of normalized corpus evidence and projection surfaces**.

---

## Role relationships across the ecosystem

These repos are related by function, not by superficial similarity.

### `ai-dev-system`
Produces runtime and decision evidence.

### `ai-systems-research`
Consumes evidence and produces durable research artifacts and meta-artifacts.

### `liveView`
Consumes read models, projections, and contract-shaped outputs to visually inspect the state of the ecosystem.

### `chatGPT_parser`
Produces normalized corpus structures and projection surfaces that can feed artifact creation, research synthesis, and contract inspection.

The shared center is not a shared application framework. The shared center is a common pattern of:

- explicit structures,
- deterministic artifact creation,
- projection/read-model derivation,
- inspection of completeness and consistency.

---

## The central interoperability principle

The most important system principle to formalize is:

**Artifacts are the interoperability layer.**

Not agents.
Not raw telemetry.
Not UI components.
Not repo-specific internal models.

Artifacts.

Everything else either:

- produces artifacts,
- consumes artifacts,
- produces evidence that can be converted into artifacts,
- or projects artifact/evidence state into specialized read models.

This principle explains why the ecosystem can remain loosely coupled while still feeling coherent.

Each repo may have different local concerns and internal models, but they become legible to the rest of the system when they emit stable contract-shaped outputs.

---

## Evidence, artifacts, projections, and contracts

To reduce ambiguity, the ecosystem should adopt four core concepts.

### Evidence
Evidence is raw or normalized record material derived from a source system or activity stream.

Examples:

- agent execution traces,
- request logs,
- telemetry events,
- parsed conversation records,
- file-level source metadata,
- normalized message/session records.

Evidence answers: **what happened?**

---

### Artifacts
Artifacts are deterministic, human-meaningful outputs created from evidence, work deltas, or synthesis passes.

Examples:

- `lesson_learned.md`
- `system_snapshot.md`
- `research_bridge.md`
- canonical artifact bundles
- session summaries
- structured writeups of conclusions or patterns

Artifacts answers: **what should be preserved or communicated?**

---

### Projections
Projections are read models or derived surfaces optimized for inspection, UI use, analysis, or downstream generation.

Examples:

- timeline read models,
- relationship graphs,
- session coverage summaries,
- graph bundles,
- projection bundles from corpus data,
- view-model oriented JSON outputs.

Projections answer: **how should this be viewed or consumed for a specific purpose?**

---

### Contracts
Contracts are the guarantees and expectations that sit between producers and consumers.

Examples:

- required artifact sets,
- schema invariants,
- bundle layouts,
- identity rules,
- field semantics,
- version boundaries,
- consumer assumptions about producer outputs.

Contracts answer: **what can another system safely rely on?**

---

## What `liveView` appears to be doing architecturally

The screenshots and description make the role of `liveView` especially important.

It is not merely “showing data.” It is functioning as a contract observability surface.

The UI elements shown suggest responsibilities such as:

- displaying required vs missing artifacts,
- surfacing optional artifacts and coverage status,
- showing session relationships,
- showing run telemetry summaries,
- presenting bundles in ways that expose drift or inconsistency,
- acting as a visual readout of contract health.

That means `liveView` is effectively the place where hidden mismatch becomes visible.

It is similar to a debugging dashboard, but at the level of artifact composition, lineage, and handoff structure rather than only process metrics.

This is architecturally significant because it gives the ecosystem a feedback loop. Producers do not merely emit outputs; they can be visually audited for shape, completeness, and interpretability.

---

## What `chatGPT_parser` appears to be doing architecturally

`chatGPT_parser` should be understood as a standalone source-system adapter for a large external cognitive corpus.

Its role is to convert GPT web chat export data into durable structures that can participate in the ecosystem.

That means it likely needs to produce one or more of the following:

- normalized corpus records,
- graph structures,
- stable projections,
- sidecar asset indexing,
- provenance-preserving bundle layouts,
- artifact creation surfaces for later research work.

The crucial point is that this parser is not only about extraction. It is about **making a corpus interoperable with the rest of the artifact system**.

That is why it is aligned with the ecosystem even though it was built as a standalone project.

---

## Canonical flow examples

Because the ecosystem has multiple valid entrypoints, it helps to define canonical flows.

### Flow A: Agent execution to artifact insight

```text
agent work
→ ai-dev-system captures execution evidence
→ ai-systems-research synthesizes deterministic artifacts
→ liveView projects and inspects the resulting contract state
→ identified drift or insight informs the next execution cycle
```

### Flow B: Engineering telemetry to visual contract debugging

```text
engineering events
→ liveView ingest normalizes telemetry
→ read models and snapshots are produced
→ UI surfaces reveal state, coverage, and mismatch
→ humans refine contracts, instrumentation, or system expectations
```

### Flow C: External corpus to artifact analysis surface

```text
ChatGPT export data
→ chatGPT_parser normalizes corpus and sidecars
→ projections/graph surfaces are emitted
→ ai-systems-research uses projections as artifact creation substrate
→ liveView optionally inspects resulting bundle/contract state
```

These flows differ in producer type but share the same architectural pattern.

---

## What success looks like

A useful success criterion for the ecosystem is:

**A new producer can enter the system, emit stable contract-shaped outputs, and become inspectable and analyzable without downstream consumers needing to understand that producer’s internals.**

That criterion is stronger than “the code runs.” It means the architecture is doing its real job.

Examples of success would include:

- a new corpus parser can produce bundle outputs that research and UI systems can consume,
- a new agent harness can emit evidence that becomes artifact-ready,
- a session can be visually inspected for completeness without custom per-session logic,
- contract drift becomes visible as a first-class debugging signal,
- artifact creation remains deterministic enough to support meta-artifact generation.

---

## Current architectural tension

The main tension in the ecosystem appears to be this:

**Capability surface has expanded faster than explicit contract definition.**

That is why the system feels powerful but slightly ad hoc.

The repositories already suggest meaningful roles and a coherent ecosystem. What is still catching up is the explicit naming of:

- canonical output units,
- stable handoff contracts,
- producer/consumer responsibilities,
- bundle identity,
- cross-repo interoperability rules.

This is a normal maturation point.

The challenge now is not to reduce ambition. The challenge is to convert emergent patterns into declared architecture.

---

## Architectural stance on coupling

The ecosystem should remain loosely coupled in implementation, but tightly defined at handoff boundaries.

That means:

- each repo may preserve local models and internal workflows,
- producers do not need to share internal architecture,
- consumers should not depend on producer internals,
- interoperability should be enforced through explicit contracts,
- adapters are acceptable and often preferable where system purposes differ.

This stance respects the actual nature of the repos.

For example:

- `chatGPT_parser` is corpus-centric,
- `ai-dev-system` is run-centric,
- `ai-systems-research` is synthesis-centric,
- `liveView` is consumption/inspection-centric.

These do not need to collapse into one universal internal model. They do need clear external contract surfaces.

---

## Proposed official framing of each repository

### `ai-dev-system`
A local agentic harness for observing, tracing, and debugging decisions made during active work.

### `ai-systems-research`
An artifact synthesis and meta-analysis system that converts evidence and work deltas into deterministic research artifacts and higher-order knowledge structures.

### `liveView`
A telemetry ingest and contract observability system whose UI acts as a near-direct read-model surface for inspecting artifact composition, lineage, and cross-system consistency.

### `chatGPT_parser`
A standalone corpus ingestion system that transforms GPT web chat export data into normalized evidence, graphs, and projections that can serve as surfaces for artifact analysis and downstream research consumption.

---

## Proposed canonical end-to-end demonstration path

To make the architecture concrete, the ecosystem should define one reference loop as an official demonstration path:

```text
ChatGPT export
→ chatGPT_parser bundle/projections
→ artifact creation session in ai-systems-research
→ canonical artifact outputs
→ liveView contract inspection and relationship visualization
```

This path is useful because:

- it includes an external corpus producer,
- it exercises normalization and projection creation,
- it demonstrates artifact synthesis,
- it validates cross-repo consumption,
- it makes contract drift visible.

Once this path is stable, it becomes easier to explain the larger ecosystem.

---

## Why this architecture matters

The system is doing something more valuable than simple logging, parsing, or document generation.

It is creating a way to:

- externalize machine and human-system activity,
- preserve that activity in inspectable forms,
- create reusable higher-order knowledge from it,
- and visually debug the contracts that make loosely coupled systems work.

In effect, the ecosystem is building an observability and artifact substrate for cognitive/engineering systems.

That combination is unusual, but it is coherent.

---

## Current source-of-truth recommendation

This document should serve as a current-state architecture overview, but it should be paired with a small number of formal contract documents over time.

Recommended follow-on documents:

1. `ECOSYSTEM_ARCHITECTURE.md`
   - high-level topology
   - repo roles
   - canonical flows

2. `ARTIFACT_MODEL.md`
   - evidence vs artifacts vs projections vs contracts
   - canonical vocabulary

3. `PRODUCER_CONTRACTS.md`
   - what producers must emit
   - identity/version/layout rules

4. `CONSUMER_EXPECTATIONS.md`
   - what `liveView` and research consumers may assume

5. `REFERENCE_PIPELINE_CHATGPT.md`
   - the official ChatGPT-export-to-artifact-analysis demo path

If a ledger repo is created or designated as the source of truth for official contracts, this document is a strong candidate to serve as the baseline framing document in that repo.

---

## Closing position

The current ecosystem is best understood as:

**an architecture for turning loosely coupled engineering and cognitive activity into deterministic artifacts, derived projections, and inspectable contract surfaces.**

The repos are not ad hoc fragments. They are specialized roles around a shared pattern.

The next phase of maturity is to formalize the contract vocabulary and handoff boundaries that the system has already been implicitly using.

That is the point at which the ecosystem becomes not just powerful in practice, but legible and reusable by design.

