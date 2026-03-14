# Synthesis

## Angle
The ecosystem now maintains two distinct contract surface families — session artifacts (retrospective) and projection contracts (operational) — and the governance gap between them explains most of the observed integration risk.

## Source Artifacts
- `analysis/cross_repo_analysis.md` (2026-03-14)
- `synthesis/cross_repo_synthesis.md` (2026-03-14)
- `research/observations/2026-03-14-cross-repo-contract-surfaces-emerge-as-distinct-artifact-class.md`
- `research/observations/2026-03-14-ranking-hygiene-as-producer-side-consumer-awareness.md`
- `research/observations/2026-03-12-session-discovery-outpaces-artifact-envelope-validation.md`
- `research/synthesis/2026-03-12-producer-diversity-stresses-schema-contracts_claude.md`
- `research/synthesis/2026-03-12-artifact-ledger-shows-ai-assisted-workflow-hardening.md`
- `artifacts/sessions/2026-03-13-chatgpt-parser-assessment/open_questions.md`

## Emerging Pattern

The research corpus tracks a consistent progression:

**Phase 1 (2026-03-07 to 2026-03-09):** Artifacts are retrospective records. Session packages preserve reasoning. The schema is designed for human-readable documentation of what happened.

**Phase 2 (2026-03-11 to 2026-03-12):** Artifacts become machine-consumable. The liveview UI treats session artifacts as data inputs. Producer diversity stresses the schema. Validation is strong at discovery (SESSION_LOG.jsonl) and weak at payload (artifact envelopes).

**Phase 3 (2026-03-13 to 2026-03-14):** A second contract family emerges. Projection artifacts (`projection_catalog.json`, `why_connected_queue.ndjson`, `hub_suggestions.ndjson`, `typed_vs_voice.ndjson`) are not retrospective — they are operational interfaces between repos. They serve consumer rendering, not producer documentation.

The two families have different characteristics:

| Dimension | Session artifacts | Projection contracts |
|---|---|---|
| Purpose | Record what happened | Bridge producer and consumer |
| Producer | Human, human+AI, or AI analyst | Automated pipeline |
| Conformance | Varies by producer type | Deterministic (code-defined) |
| Consumer | Research hub, research UI | Workbench rendering pipeline |
| Validation | SESSION_LOG.jsonl discovery | Catalog + Zod schema (partial) |
| Governance | ARTIFACT_SCHEMA.md | None (implicit) |
| Evolution rate | Slow (schema changes by design) | Fast (new surfaces added by implementation) |

## Cross-Session Insight

The 2026-03-12 synthesis "producer-diversity-stresses-schema-contracts" identified three producer types and noted that conformance varies more by producer type than by schema awareness. Today's work adds a fourth producer type (automated pipeline) and reveals that the variation has bifurcated into two separate problem domains:

1. **Session artifact conformance** — where the challenge is accommodating diverse producer methodologies within a common heading structure
2. **Projection contract conformance** — where the challenge is ensuring that deterministic pipeline output matches deterministic consumer expectations

These are different engineering problems. Session artifact conformance benefits from tolerance (the "tolerant renderer" pattern noted in the 2026-03-12 synthesis). Projection contract conformance benefits from strictness (the Zod validation in liveview).

The earlier question about schema versioning (`2026-03-12-session-artifact-schema-versioning-question.md`) asked whether version should be declared per artifact or per session folder. The answer may be: per artifact *for session artifacts*, and per catalog version *for projection contracts*. The two families version differently because they evolve differently.

## Connection to the shared-contract vs. adapters question

The chatgpt-parser-assessment session's `open_questions.md` identifies the highest-risk architectural ambiguity as: "Does the ecosystem want one shared artifact contract across all repos, or multiple producer-specific contracts with adapters?"

This synthesis suggests the question contains a false dichotomy. The ecosystem already has two contract families, and they naturally want different governance:

- **Session artifacts** → shared contract (ARTIFACT_SCHEMA.md), tolerant consumption, per-producer conformance levels
- **Projection contracts** → per-surface contracts, strict validation, versioned catalogs

The "shared vs. adapters" question applies differently to each family. Session artifacts benefit from a shared envelope with producer-type metadata. Projection contracts benefit from explicit per-surface schemas with versioned catalogs acting as the discovery layer.

## Tensions / Counterpoints
- The bifurcation may be premature — projection contracts could be treated as a special case of session artifacts (just with higher conformance requirements)
- The sample is still small: one producer (chatGPT_parser) emitting to one consumer (liveview workbench). A second producer-consumer pair might reveal that the bifurcation is an artifact of this specific system, not a general pattern
- The ranking hygiene commit shows the producer embedding consumer awareness into its pipeline, which could be seen as unhealthy coupling rather than maturation
- Separating governance for two families increases the total contract surface area of the ecosystem

## Candidate Claims
- Artifact-driven systems naturally bifurcate into retrospective (session) and operational (projection) contract families as they mature
- Each family requires different governance: tolerance for session artifacts, strictness for projection contracts
- The "shared contract vs. adapters" architectural decision should be answered separately for each family rather than as a single ecosystem-wide choice
- Producer-side consumer awareness (ranking hygiene, display-aware limits) is a signal that the system has crossed from file-sharing to contract-sharing
