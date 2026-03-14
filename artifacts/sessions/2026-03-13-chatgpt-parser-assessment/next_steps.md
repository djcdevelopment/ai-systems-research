# Next Steps

## Immediate Stabilization

### 1. Reconcile architectural state docs
- Action:
  - align `ARCHITECTURE_STATE.md`, `PLAN4.md`, and `README.md` on whether image/OCR graph augmentation is implemented.
- Rationale:
  - current docs disagree, which weakens downstream trust in repo state.
- Expected payoff:
  - lower operator ambiguity and cleaner research handoff.

### 2. Add a canonical bundle manifest for parser runs
- Action:
  - emit one top-level manifest that inventories normalized, graph, sidecar, and projection outputs plus versions and fingerprints.
- Rationale:
  - current manifests are useful but fragmented across ingest, graph, and snapshot layers.
- Expected payoff:
  - easier ingestion, validation, and cross-repo interoperability.

### 3. Persist graph warning details, not just counts
- Action:
  - extend `graph_manifest.json` to optionally include warning payloads or a warnings artifact path.
- Rationale:
  - `snapshot_manifest.py` already documents the absence of detailed graph warnings as a limitation.
- Expected payoff:
  - better debugging, safer downstream automation, and higher research value.

### 4. Add runtime schema validation for emitted and optional-header records
- Action:
  - enforce JSON schema or equivalent structural validation in CLI commands.
- Rationale:
  - schemas exist on disk but are not obviously applied in execution.
- Expected payoff:
  - stronger contracts and safer downstream consumers.

## Pipeline Contract Hardening

### 5. Create a source-system contract file for `chatGPT_parser`
- Action:
  - add a root contract similar to `liveView/RESEARCH_LINK.md` declaring:
    - system identity
    - artifact families
    - handoff expectations
    - research relationship
- Rationale:
  - the repo is already behaving like a source system but without explicit ecosystem identity.
- Expected payoff:
  - easier research indexing and less implicit coupling.

### 6. Define a stable parser output contract
- Action:
  - formalize a `conversation corpus bundle` contract covering:
    - normalized records
    - graph records
    - sidecars
    - projections
    - manifests
    - versioning rules
- Rationale:
  - current structure is legible but repo-local.
- Expected payoff:
  - direct adapter work becomes tractable, and UI/research consumers can depend on stable fields.

### 7. Introduce producer metadata parity with `ai-dev-system`
- Action:
  - standardize fields such as:
    - `schema_version`
    - `generated_by`
    - `generated_at`
    - `run_id` or `build_id`
    - artifact inventory
    - input fingerprint
- Rationale:
  - the ecosystem currently has similar ideas expressed in different shapes.
- Expected payoff:
  - simpler cross-producer observability and ledgering.

### 8. Add explicit corpus/run identity
- Action:
  - give each ingest/graph/projection cycle a stable dataset or build identifier that propagates across artifacts.
- Rationale:
  - current manifests reference timestamps and hashes, but cross-file lineage could be more explicit.
- Expected payoff:
  - easier replay, caching, UI linking, and research references.

## Multimodal Expansion

### 9. Decide whether image semantics stays sidecar-only or becomes graph/projection input
- Action:
  - make an explicit architectural choice and document it.
- Rationale:
  - image semantics linkage exists, but downstream use is currently minimal.
- Expected payoff:
  - prevents ambiguous partial integration.

### 10. Harden matching contracts for transcripts/OCR/semantics against real export variance
- Action:
  - test with more real datasets and document accepted matching heuristics and failure modes.
- Rationale:
  - current matching is heuristic and likely sensitive to naming drift.
- Expected payoff:
  - fewer silent mismatches and stronger multimodal reliability.

### 11. Add richer provenance for multimodal-derived graph edges
- Action:
  - include source-file path, matching rule, and sidecar record id consistently on additive edges/nodes.
- Rationale:
  - current provenance is good, but more explicit payloads would help audits and UI rendering.
- Expected payoff:
  - better explainability for OCR/transcript-derived evidence.

### 12. Gather real sample exports that stress non-text ChatGPT features
- Action:
  - validate against exports containing:
    - voice usage
    - screenshots/images
    - browser/tool outputs
    - multiple branches
    - hidden/system messages
- Rationale:
  - current tests are strong but still fixture-bounded.
- Expected payoff:
  - better confidence that the parser is research-grade rather than fixture-grade.

## Research/UI Integration

### 13. Register `chatGPT_parser` in research system contracts
- Action:
  - add it to `ai-systems-research/SYSTEM_INDEX.md` and create a small integration note or observation artifact series.
- Rationale:
  - it is now a meaningful source system in the ecosystem.
- Expected payoff:
  - traceable research references and less repo-external tribal knowledge.

### 14. Build a minimal adapter from parser outputs to `liveView`
- Action:
  - choose one narrow path:
    - map parser artifacts into current `liveView` snapshot files, or
    - teach `liveView/ui` to load parser graph/projection bundles directly.
- Rationale:
  - right now there is no turnkey consumer for these artifacts.
- Expected payoff:
  - immediate visual inspection loop for the parser corpus.

### 15. Package parser builds into research session artifacts
- Action:
  - after major dataset runs, emit research session packages with:
    - parser system snapshot
    - research bridge
    - lessons learned
    - request log
- Rationale:
  - parser work is already producing research-relevant evidence.
- Expected payoff:
  - closes the implementation-to-research loop.

### 16. Define a graph/projection exploration UI question set before adding more projections
- Action:
  - specify the user questions the next UI should answer:
    - conversation continuity
    - artifact lineage
    - modality mix
    - corpus search
    - confidence/review overlays
- Rationale:
  - projections already exist; consumer intent should now shape further expansion.
- Expected payoff:
  - prevents projection sprawl and improves downstream leverage.
