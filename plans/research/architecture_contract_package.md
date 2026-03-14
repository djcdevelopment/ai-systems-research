# Architecture Contract Package

This package extends the current architecture overview into operational contract documents.

Recommended storage location for the first working version: **`chatGPT_parser/docs/architecture/`**

Rationale:

- `chatGPT_parser` is currently the cleanest place to formalize the external-corpus-to-artifact pipeline.
- It is standalone enough to hold stable architecture docs without being overly entangled with one runtime harness.
- It is directly connected to the current need: turning GPT export data into projection surfaces that feed artifact analysis.
- It can serve as the first formal producer-contract host while the broader ledger/source-of-truth repo is still emerging.

Recommended near-term directory layout:

```text
chatGPT_parser/
  docs/
    architecture/
      CURRENT_ARCHITECTURE_OVERVIEW.md
      ARTIFACT_MODEL.md
      PRODUCER_CONTRACTS.md
      REFERENCE_PIPELINE_CHATGPT.md
```

Longer-term recommendation:

Once the contract vocabulary stabilizes, consider either:

1. promoting these documents into a dedicated ledger repo, or
2. keeping canonical source-of-truth contracts in the ledger repo while leaving repo-local annotated copies in each producing repo.

A reasonable maturity path is:

- **now:** store in `chatGPT_parser/docs/architecture/`
- **later:** promote shared contract docs into the ledger repo
- **then:** leave only repo-local extensions or implementation notes in individual repos

---

# ARTIFACT_MODEL.md

## Purpose

This document defines the canonical vocabulary for the ecosystem. Its job is to reduce ambiguity between evidence capture, artifact creation, projection building, and consumer handoff.

The goal is not theoretical purity. The goal is to create enough semantic precision that producers and consumers across repositories can interoperate without needing to understand one another’s internals.

---

## Why this document exists

The ecosystem now spans multiple repositories with distinct concerns:

- runtime agent tracing,
- telemetry ingestion,
- artifact synthesis,
- external corpus normalization,
- UI contract inspection.

Those systems already share patterns, but the vocabulary is still partly implicit. This document makes the shared model explicit.

---

## Canonical terms

### 1. Evidence

**Definition**
Evidence is raw, captured, or normalized record material derived from a source activity or source system.

Evidence is the closest durable representation of “what happened” before higher-order interpretation.

**Examples**

- agent request logs
- orchestration traces
- telemetry events
- normalized conversation messages
- parsed source-file metadata
- transcript linkage records
- OCR output records
- image semantic linkage records
- run manifests describing source activity

**Properties of evidence**

Evidence should be:

- source-attributable,
- provenance-preserving,
- append-friendly where appropriate,
- minimally interpretive,
- reproducible from the same source inputs.

**Primary question evidence answers**

> What happened?

---

### 2. Artifacts

**Definition**
Artifacts are deterministic, human-meaningful outputs created from evidence, work deltas, synthesis passes, or interpretation routines.

Artifacts are not just files. They are durable units of preserved meaning.

**Examples**

- `lesson_learned.md`
- `system_snapshot.md`
- `research_bridge.md`
- `integration_assessment.md`
- `next_steps.md`
- structured session summaries
- packaged analytical writeups

**Properties of artifacts**

Artifacts should be:

- intentionally shaped,
- deterministic relative to their generation process,
- understandable by humans,
- suitable for reuse as future inputs,
- organized into stable bundles when emitted as a set.

**Primary question artifacts answer**

> What should be preserved, communicated, or reused?

---

### 3. Projections

**Definition**
Projections are derived read models optimized for a specific consumer purpose such as UI rendering, graph traversal, relationship inspection, summarization, or downstream generation.

A projection is not necessarily the canonical truth of a system. It is a purpose-built view over evidence and/or artifacts.

**Examples**

- session timeline read models
- artifact composition summaries
- relationship graph datasets
- coverage summaries
- run snapshot summaries
- corpus view models
- graph bundles prepared for UI inspection

**Properties of projections**

Projections should be:

- purpose-specific,
- derivable from upstream evidence/artifacts,
- disposable and rebuildable,
- versioned when downstream consumers depend on shape,
- consumer-legible.

**Primary question projections answer**

> How should this be viewed or consumed for a specific use?

---

### 4. Contracts

**Definition**
Contracts are the explicit guarantees and expectations between producers and consumers.

Contracts define what a producer promises and what a consumer may safely assume.

**Examples**

- required artifact sets
- field-level schema guarantees
- bundle layout rules
- identity invariants
- required metadata
- version compatibility boundaries
- interpretation semantics for fields and statuses

**Properties of contracts**

Contracts should be:

- explicit,
- testable,
- versionable,
- stable enough to support downstream reuse,
- independent of producer internals.

**Primary question contracts answer**

> What can another system rely on without reading my code?

---

## Relationship between the four terms

The four concepts form a layered model.

```text
activity/source system
    ↓
evidence
    ↓
artifacts
    ↓
projections
    ↓
consumers / inspection / further artifact creation
```

Contracts sit across each handoff boundary.

```text
producer --(contract)--> consumer
```

This means:

- evidence can be consumed directly,
- artifacts can be created from evidence,
- projections can be built from evidence and/or artifacts,
- artifacts themselves can become evidence for future synthesis,
- every handoff should be governed by explicit contract assumptions.

---

## Distinctions that matter

### Evidence is not the same thing as an artifact

Evidence preserves source behavior or source records.
Artifacts preserve interpreted meaning.

A raw request log is evidence.
A lesson derived from many request logs is an artifact.

---

### An artifact is not the same thing as a projection

An artifact is a durable preserved output intended to carry meaning.
A projection is a specialized view shaped for a consumer.

A `system_snapshot.md` is an artifact.
A timeline read model used by `liveView` is a projection.

---

### A contract is not the same thing as a schema file

A schema may be part of a contract, but a contract also includes:

- required presence rules,
- version assumptions,
- semantic meaning,
- identity constraints,
- layout expectations,
- rebuild expectations.

A JSON Schema alone rarely expresses the full contract.

---

### A projection can be canonical for a consumer without being globally canonical

A UI-oriented view model may be the canonical surface for a UI, while still being downstream of a more canonical evidence or artifact layer.

This distinction matters because it preserves local optimization without confusing read models for source truth.

---

## Canonical lifecycle model

The ecosystem should assume the following generalized lifecycle:

1. activity occurs,
2. evidence is captured or normalized,
3. artifacts are synthesized where durable meaning is needed,
4. projections are derived for targeted consumers,
5. contract inspection validates completeness and compatibility,
6. resulting outputs may seed future evidence or artifact creation.

This model allows multiple producer types to coexist.

---

## Producer and consumer interpretation rules

### Producer responsibilities

A producer should clearly identify:

- what source it represents,
- what evidence it emits,
- what artifacts it may emit,
- what projections it publishes,
- what contracts it guarantees,
- what is intentionally out of scope.

### Consumer responsibilities

A consumer should:

- depend only on documented contracts,
- avoid relying on producer internals,
- treat projections as purpose-specific,
- fail visibly when required contract expectations are not met,
- preserve provenance when composing derived outputs.

---

## Meta-artifacts and recursive use

A defining property of the ecosystem is that artifacts can become inputs to future artifact creation.

This is not an accidental side effect. It is one of the architecture’s strengths.

Examples:

- a session snapshot becomes evidence for a research synthesis,
- multiple lessons become input to a higher-order pattern document,
- parser projections become surfaces for artifact generation,
- UI-visible mismatches drive new contract artifacts.

This recursive reuse is why deterministic artifact creation matters. Without stable shaping, higher-order artifact layers become unreliable.

---

## Official model statement

The official working model of the ecosystem is:

> Source activity is captured as evidence, transformed into artifacts where durable meaning is required, projected into consumer-specific read models, and connected through explicit contracts that preserve interoperability across loosely coupled systems.

---

# PRODUCER_CONTRACTS.md

## Purpose

This document defines the producer-side contract model for the current ecosystem.

It does not attempt to force all repositories into one internal architecture. Instead, it establishes the minimum external expectations a producer must satisfy to become interoperable.

---

## Architectural stance

The ecosystem should remain:

- **loosely coupled internally**, and
- **tightly defined at handoff boundaries**.

This means each producer may preserve local implementation models, but must emit stable contract-shaped outputs at its boundary.

Adapters are valid and expected where producer types differ.

---

## What counts as a producer

A producer is any system or repo that emits evidence, artifacts, projections, or bundle structures intended for downstream consumption.

Current producer categories include:

1. runtime execution producers
2. telemetry ingest producers
3. external corpus producers
4. manual or research-session artifact producers

A single repo may play more than one producer role.

---

## Required producer identity

Every producer should define a stable producer identity.

Minimum recommended fields:

- `system_id`
- `producer_type`
- `contract_version`
- `bundle_version`
- `generated_at`
- `source_scope`

### Suggested examples

- `ai-dev-system`
  - `system_id`: `ai-dev-system`
  - `producer_type`: `runtime_execution`

- `liveView-ingest`
  - `system_id`: `liveview`
  - `producer_type`: `telemetry_ingest`

- `ai-systems-research`
  - `system_id`: `ai-systems-research`
  - `producer_type`: `artifact_synthesis`

- `chatGPT_parser`
  - `system_id`: `chatgpt-parser`
  - `producer_type`: `external_corpus`

Recommendation: standardize on lowercase kebab-case for `system_id` values.

---

## Minimum producer contract surface

A producer should publish, either directly or through a manifest, enough information for consumers to answer the following:

1. Who produced this?
2. What source data or activity does it represent?
3. What bundle or output set is being published?
4. What files/structures are included?
5. Which outputs are evidence, artifacts, and projections?
6. What version rules apply?
7. What invariants may be relied upon?

---

## Recommended bundle manifest fields

Every significant producer bundle should expose a top-level manifest.

Recommended fields:

```json
{
  "system_id": "chatgpt-parser",
  "producer_type": "external_corpus",
  "contract_version": "1",
  "bundle_version": "1",
  "generated_at": "ISO-8601 timestamp",
  "source_scope": {
    "source_type": "chatgpt_export",
    "input_count": 0,
    "sidecar_types": []
  },
  "bundle": {
    "bundle_type": "corpus_bundle",
    "root_path": "relative/path",
    "contents": []
  },
  "invariants": [],
  "optional_outputs": [],
  "dependencies": []
}
```

This is illustrative, not final. The key requirement is that the manifest make the boundary legible.

---

## Required producer guarantees

Each producer should explicitly guarantee the following categories where applicable.

### 1. Identity invariants

Examples:

- stable `system_id`
- stable run/session/corpus identity semantics
- no ambiguous meaning for top-level identifiers

### 2. Bundle layout invariants

Examples:

- manifest location
- stable directory structure rules
- known locations for evidence/artifacts/projections

### 3. Semantic invariants

Examples:

- what `complete` means
- what constitutes a required artifact
- interpretation of coverage fields
- meaning of relationship edges

### 4. Rebuild invariants

Examples:

- projections are derivable from upstream evidence
- bundle contents are reproducible from same source inputs
- generated files can be refreshed without changing semantic meaning unexpectedly

### 5. Provenance invariants

Examples:

- source lineage is preserved
- derived outputs reference source context
- consumers can trace derived outputs back to origin class

---

## Recommended output categories per producer

Not every producer must emit every category, but the producer should be explicit.

### Evidence outputs

Examples:

- events
- logs
- normalized records
- transcripts
- OCR records

### Artifact outputs

Examples:

- session documents
- research writeups
- system snapshots

### Projection outputs

Examples:

- UI read models
- relationship graphs
- timeline summaries
- corpus projections

### Manifest/contract outputs

Examples:

- bundle manifest
- schema version declaration
- contract metadata

---

## Current repo-specific producer framing

### `ai-dev-system`

Primary producer role:
- runtime execution evidence producer

Expected external contract surface:
- run identity
- request/decision trace outputs
- reproducible session/run bundle structure
- enough provenance to support downstream artifact synthesis

### `ai-systems-research`

Primary producer role:
- deterministic artifact and meta-artifact producer

Expected external contract surface:
- research session identity
- canonical artifact bundle membership
- required/optional artifact composition
- explicit linkage to evidence or source session context

### `liveView`

Primary producer role:
- telemetry ingest producer and UI-oriented projection producer

Expected external contract surface:
- ingest snapshot identity
- event normalization guarantees
- read-model shape guarantees for the UI
- contract-health semantics visible to inspection surfaces

### `chatGPT_parser`

Primary producer role:
- external corpus evidence and projection producer

Expected external contract surface:
- corpus identity
- normalized conversation/message/source records
- graph/projection bundle membership
- sidecar asset linkage/provenance rules
- contract-ready bundle manifest for downstream research/UI use

---

## Shared-vs-adapter decision

### Recommended stance

Use **producer-specific contracts with adapters**, not a single universal native contract for every repo.

### Rationale

The repos are optimized around different centers:

- `ai-dev-system` is run-centric,
- `liveView` is inspection/read-model-centric,
- `ai-systems-research` is synthesis-centric,
- `chatGPT_parser` is corpus-centric.

Forcing a single universal native model too early would erase useful distinctions and create brittle abstractions.

A better pattern is:

- each producer owns a clear external bundle contract,
- shared vocabulary defines the categories,
- adapters bridge bundles into consumer-specific shapes.

### Consequence

This means consumer repos should prefer documented adapters over silent assumptions.

That is a feature, not a weakness.

---

## Minimum compliance checklist for a new producer

A producer should not be considered ecosystem-ready until it can answer yes to the following:

- Does it expose a stable `system_id`?
- Does it define what kind of producer it is?
- Does it publish a manifest or equivalent boundary document?
- Does it separate evidence, artifacts, and projections clearly enough for consumers?
- Does it document required vs optional outputs?
- Does it state key invariants?
- Can downstream systems consume it without reading internal source code?

---

## Official producer contract statement

The official stance of the ecosystem is:

> Producers may differ internally, but each must publish a stable, explicit, provenance-preserving contract surface that allows evidence, artifacts, and projections to be consumed through documented assumptions rather than inferred internals.

---

# REFERENCE_PIPELINE_CHATGPT.md

## Purpose

This document defines the official reference pipeline for taking GPT web chat export data through normalization, projection, artifact creation, and contract inspection.

It exists to make one end-to-end path fully explicit.

The ecosystem supports multiple flows, but this path should serve as the clearest demonstration of cross-repo interoperability.

---

## Why this pipeline matters

The ChatGPT export pipeline is valuable because it exercises nearly every important architectural idea at once:

- external corpus ingestion,
- normalization into durable evidence,
- projection generation,
- artifact creation from non-runtime source material,
- contract-based downstream consumption,
- visual inspection of resulting outputs.

If this pipeline is legible and functional, the larger architecture becomes much easier to explain and validate.

---

## Pipeline summary

The canonical reference path is:

```text
ChatGPT web export
→ chatGPT_parser
→ normalized corpus bundle + projections
→ ai-systems-research artifact creation session
→ canonical artifact bundle
→ liveView inspection surfaces
```

This path should be treated as the reference loop for external corpus producers.

---

## Stage 1: Source input

### Source

Input consists of GPT web export material, likely including:

- `conversations-*.json`
- referenced sidecar files
- images
- audio
- transcript-related outputs
- OCR or semantic enrichment sidecars where available or generated later

### Goal of this stage

Establish a reproducible, bounded source corpus.

### Required properties

- source inputs are discoverable,
- corpus scope is explicit,
- source provenance is retained,
- input set can be reprocessed.

---

## Stage 2: Corpus normalization

### Producer
`chatGPT_parser`

### Goal

Transform raw export data into durable evidence structures.

### Expected evidence outputs

Examples may include:

- normalized conversation records
- normalized message records
- source file linkage records
- sidecar references
- transcript linkage records
- OCR linkage records
- image semantic linkage records

### Key requirement

This stage should preserve provenance and establish stable identity semantics for the corpus.

### Output class

**Evidence**

---

## Stage 3: Projection and graph surface creation

### Producer
`chatGPT_parser`

### Goal

Derive consumer-usable surfaces from normalized evidence.

### Expected projection outputs

Examples may include:

- corpus graph bundle
- session/conversation projections
- relationship surfaces
- asset linkage summaries
- UI/read-model-ready datasets
- top-level corpus manifest

### Key requirement

Projections should be purpose-specific, rebuildable, and clearly versioned when consumed downstream.

### Output class

**Projections**

---

## Stage 4: Artifact creation session

### Producer/consumer relationship

`ai-systems-research` consumes the parser outputs and produces deterministic artifacts.

### Goal

Use the corpus evidence/projections as an artifact-creation substrate.

### Expected artifact outputs

Examples may include:

- `system_snapshot.md`
- `integration_assessment.md`
- `next_steps.md`
- `open_questions.md`
- `lesson_learned.md`
- future corpus-derived research artifacts

### Key requirement

Artifacts should preserve linkage back to the parser-produced corpus context, either directly or through the session/package manifest.

### Output class

**Artifacts**

---

## Stage 5: Contract inspection and visual debugging

### Consumer
`liveView`

### Goal

Render the resulting bundle state so humans can inspect:

- artifact composition,
- required vs missing outputs,
- relationship structure,
- coverage and session state,
- drift between expectation and reality.

### Key requirement

`liveView` should not need to understand parser internals. It should consume a documented handoff surface, directly or through a narrow adapter.

### Output class

**Inspection / read-model consumption**

---

## Stage 6: Feedback into system design

### Goal

Use what was learned from the inspected outputs to refine:

- parser contracts,
- artifact generation rules,
- projection structures,
- consumer assumptions,
- future analysis workflows.

This closes the loop.

---

## Canonical handoff recommendation

### Recommended handoff artifact

For the ChatGPT reference pipeline, the recommended handoff should be a **top-level corpus bundle** containing:

1. evidence outputs,
2. projection outputs,
3. contract metadata / manifest,
4. optional derived graph structures.

This is preferable to exposing only raw graph data or only consumer-specific snapshots.

### Rationale

- research consumers often need both evidence and projections,
- UI consumers may prefer projections or adapted snapshots,
- a bundle allows different consumers to derive what they need,
- provenance is easier to preserve when evidence and projections stay associated.

---

## Adapter recommendation for `liveView`

The narrowest viable integration path is:

1. `chatGPT_parser` emits a stable top-level corpus bundle manifest,
2. a small adapter maps bundle outputs into the current `liveView` snapshot/read-model contract,
3. `liveView` renders the adapted read model without learning parser internals.

This should be preferred over immediate first-class deep parser awareness inside the UI.

---

## Acceptance criteria for the reference pipeline

The reference pipeline should be considered established when all of the following are true:

### Input and normalization
- a bounded ChatGPT export corpus can be processed reproducibly,
- normalized evidence outputs are emitted with stable identities,
- sidecar provenance is preserved.

### Bundle contract
- a top-level corpus manifest exists,
- bundle membership is explicit,
- evidence vs projections are distinguishable,
- version/identity rules are documented.

### Artifact creation
- `ai-systems-research` can consume the bundle and produce deterministic session artifacts,
- artifacts clearly correspond to the source corpus/session context.

### UI inspection
- `liveView` can render the resulting outputs through a documented handoff path,
- required/missing outputs or relationship structures become visually inspectable,
- failures of the contract surface are visible rather than implicit.

### Ecosystem value
- the path is explainable without reading producer internals,
- the same contract pattern can be reused for future external corpus producers.

---

## Official reference pipeline statement

The official reference path for external corpus ingestion is:

> GPT web export data is normalized into a durable corpus bundle by `chatGPT_parser`, used by `ai-systems-research` as an artifact creation substrate, and surfaced through `liveView` for contract inspection and relationship-oriented visual debugging.

---

## Recommended next implementation documents

After this reference pipeline document, the next concrete documents worth creating are:

1. `CHATGPT_PARSER_BUNDLE_SPEC.md`
2. `LIVEVIEW_CHATGPT_ADAPTER_SPEC.md`
3. `RESEARCH_HANDOFF_CONTRACT.md`

These would convert the reference pipeline from architectural intent into implementation-ready boundaries.

