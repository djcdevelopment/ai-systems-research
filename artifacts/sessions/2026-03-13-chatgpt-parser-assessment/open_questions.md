# Open Questions

## Unresolved Issues
- What is the canonical `system_id` for this repo?
  - Candidate inference: `chatgpt_parser` or `chatgpt-parser`.
- Is the intended primary consumer a research workflow, a UI workflow, or both?
- Is `chatGPT_parser` meant to stay a standalone source system, or eventually fold into `liveView/ingest` as a specialized ingest mode?
- Should the graph be treated as the canonical handoff artifact, or should projections/snapshot manifests be the primary downstream interface?

## Assumptions Requiring Validation
- Assumption:
  - the parser is intended for real ChatGPT export corpora, not just a local experiment.
  - Basis: repo scope, planning depth, multimodal features, and durable output layout.
- Assumption:
  - the intended end state is a research-grade multimodal artifact corpus.
  - Basis: additive modality separation, lineage projections, overlays, and snapshot manifest design.
- Assumption:
  - `image_semantics` is intentionally optional and downstream-light for now.
  - Basis: implementation exists, but code search shows little downstream use beyond manifest counting.
- Assumption:
  - the JSON Schemas under `schemas/` are meant as future contract hardening rather than active validation.
  - Basis: schema files exist, but runtime validator usage was not evident in inspected code.

## Areas Where More Runtime Evidence Would Help
- A real large ChatGPT export with:
  - branches
  - hidden/system nodes
  - tool/browsing outputs
  - dictation/voice messages
  - image attachments
- Real transcript/OCR/semantics directories produced by external tools, not only fixtures.
- A sample corpus large enough to test whether current projections stay performant and legible.
- Evidence of how often pointer matching fails or resolves ambiguously in real datasets.

## Integration Questions
- Which repo should own UI exploration of parser outputs?
  - `liveView/ui`
  - a new parser-specific UI
  - research-only markdown/graph workflows
- Should parser output be adapted into the existing `liveView` snapshot contract, or should the ecosystem add a second contract for graph/projection bundles?
- Does `ai-dev-system` need a generalized producer manifest pattern that `chatGPT_parser` can reuse?
- Should research handoff happen per parser build, per dataset snapshot, or only after interpretive sessions?

## Contract Questions
- What are the versioning rules for:
  - normalized records
  - graph schema
  - sidecar schemas
  - projection schemas
  - snapshot manifest schema
- Are optional header/meta records part of the stable contract or an experimental convenience?
- Should overlays have their own explicit contract file and review workflow?
- Is there a canonical retention policy for raw exports, normalized outputs, and sidecars?

## Highest-Risk Ambiguity
- The biggest ambiguity is not technical parsing correctness.
- It is whether the ecosystem wants one shared artifact contract across repos, or multiple producer-specific contracts with adapters.
- Until that is decided, `chatGPT_parser` can keep growing useful artifacts without becoming plug-compatible with the rest of the system.
