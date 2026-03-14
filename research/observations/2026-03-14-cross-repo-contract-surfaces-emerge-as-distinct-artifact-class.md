# Observation

## Title
Cross-repo contract surfaces emerge as a distinct artifact class not covered by the session artifact schema

## Context
All prior session artifacts describe work within or about a single system. The 2026-03-13 work introduces a new pattern: artifacts that exist to bridge two repos at runtime, not just to record what happened in a session.

## Evidence
- `chatGPT_parser` now emits `projection_catalog.json` — a manifest declaring what projection surfaces exist, their layer, kind, and stability. This is consumed by `liveview/ui`'s `loadProjectionCatalog.ts` which validates it against a Zod schema.
- The catalog schema (`{ catalog_version, snapshot_id, generated_at, surfaces[].{name, layer, kind, stability} }`) is structurally different from any artifact in `ARTIFACT_SCHEMA.md`. It is not a session artifact — it is a runtime contract surface.
- The suggestion queue (`why_connected_queue.ndjson`) is shaped specifically for liveview's `QueuePairCards` renderer. The queue's `primary_anchor`, `anchor_type`, `confidence`, and `queue_bucket` fields are rendering-aware — they exist to serve the consumer, not to describe what happened.
- The `typed_vs_voice.ndjson` projection carries modality data from audio sidecars into a per-conversation summary that liveview renders (currently as raw rows, but the intent is cross-repo consumption).

## What Happened
The ecosystem now produces two categories of artifacts: (1) session artifacts that record what happened (governed by `ARTIFACT_SCHEMA.md`), and (2) projection contract surfaces that serve as runtime interfaces between repos. The second category emerged without an explicit schema or governance document.

## Why It Matters
The existing research (observation `2026-03-12-session-discovery-outpaces-artifact-envelope-validation.md`) found that validation strength drops after the session index boundary. The same pattern appears at the cross-repo level: the projection catalog exists as a de facto contract, but no validation exists at the boundary between producer and consumer. The Zod schema in liveview validates shape, but nobody verifies that the producer actually emits what the consumer expects.

This observation also extends the producer-diversity synthesis (`2026-03-12-producer-diversity-stresses-schema-contracts_claude.md`). That synthesis identified three producer types based on who created session artifacts. Now there is a fourth production pattern: automated pipeline output designed for cross-repo consumption. This producer type has different conformance characteristics — it is deterministic, schema-stable, and machine-to-machine, unlike the human-narrative, human+AI, and AI-analysis producers previously observed.

## Short Pattern Explanation
Session artifacts and projection contract surfaces are solving different problems (recording vs. bridging) but are currently governed by the same informal process. The contract surfaces need their own governance.
