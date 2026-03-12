# Synthesis

## Angle
The three sessions represent three distinct producer profiles, and schema conformance varies more by producer type than by schema awareness. Producer diversity, not schema versioning, is the primary source of contract stress.

## Source Artifacts
- `artifacts/sessions/2026-03-09-conversation-ledger/` (all files)
- `artifacts/sessions/2026-03-11-chat-artifact-protocol/` (all files)
- `artifacts/sessions/2026-03-11-liveview-ui/` (all files)
- `ARTIFACT_SCHEMA.md`

## Producer Profiles

**Session 1 (2026-03-09-conversation-ledger)**: Human operator manually mapping a philosophical conversation into artifact structure.
- Produces 4 of 7 canonical artifacts (no `system_snapshot.md`, `request_log.json` is minimal, no `session_reasoning_graph.json`)
- Heading structure follows `ARTIFACT_SCHEMA.md` most closely for `research_bridge.md`
- Evidence is narrative and unsourced
- `request_log.json` uses the canonical fields but `files_touched` is empty

**Session 2 (2026-03-11-chat-artifact-protocol)**: Human+AI designing restart infrastructure for the research repo.
- Produces 7 artifacts (all canonical types)
- Heading structure diverges from schema in `research_bridge.md` and `lesson_learned.md`
- `request_log.json` uses a reduced shape (`session_id` + `decisions` only, missing `request_id`, `system_id`, `inputs_used`, `files_touched`, `open_questions`, `artifacts_generated`)
- `session_reasoning_graph.json` uses reduced shape (nodes without `evidence`, `outcome`, or `next` arrays)

**Session 3 (2026-03-11-liveview-ui)**: AI analyzing code to produce evidence-grounded artifacts with an explicit analysis prompt.
- Produces 8 files (7 canonical + `analysis_prompt.md`)
- Heading structure diverges significantly from schema (numbered sections, architectural framing)
- `request_log.json` uses a completely different shape (`repo_state`, `assessment`, `verified_observations`, `soft_contract_points`) that is structurally richer but field-incompatible with the canonical definition
- `session_reasoning_graph.json` uses a completely different shape (per-artifact assessment rather than session-level reasoning nodes)

## Emerging Pattern
Each producer type produces a different dialect of the same schema. The divergence is not random — it reflects what each producer profile naturally captures:
- Human narrative producers capture meaning but not evidence links
- Human+AI protocol producers capture structural decisions but reduce field shapes
- AI code analysis producers capture rich evidence but reshape artifacts to fit the analysis methodology

## Cross-Session Insight
The existing question about schema versioning (`research/questions/2026-03-12-session-artifact-schema-versioning-question.md`) asks how to declare conformance level. This synthesis suggests the answer may need to include producer type as a dimension, not just schema version. Two artifacts with the same schema version but different producer types will have structurally different payloads.

This has direct implications for the liveview research UI: renderer read models that assume specific field names (as noted in `artifacts/sessions/2026-03-11-liveview-ui/lesson_learned.md`) will encounter different field sets from different producer types, not just from schema evolution.

## Tensions / Counterpoints
- The sample is only 3 sessions, so the producer-type pattern could be coincidental
- Forcing all producers to emit identical field shapes could reduce the quality of what each producer naturally captures
- The tolerant-renderer pattern already in the UI may be sufficient to handle producer diversity without formal producer typing
- Adding producer metadata to the schema increases the envelope's surface area, which is already identified as underspecified

## Candidate Claims
- Schema conformance is a function of producer capability and methodology, not just schema awareness
- Downstream consumers need to handle producer diversity as a first-class concern, not just schema versioning
- The research UI's tolerant-renderer approach may be architecturally correct precisely because it absorbs producer variation, not just schema drift
