# Observation

## Title
Projection ranking hygiene is the first evidence of producer-side consumer awareness in the ecosystem

## Context
The chatGPT_parser ranking hygiene commit (93caa02, 2026-03-13 20:29) restructured the suggestion queue to be useful to a downstream UI, not just internally correct.

## Evidence
- `src/chatgpt_parser/projections/suggestion_queue.py` introduces `should_drop_candidate()` which filters unpresentable anchors — API endpoints, date-like paths, punctuation-only tokens. "Presentable" is a consumer-facing concept, not a data-integrity concept.
- `classify_queue_bucket()` assigns `strong_operational`, `supported_anchor`, `anchor_only`, `exploratory` tiers. These categories describe how interesting a suggestion is to a human viewer, not how valid it is as data.
- `MAX_PER_ANCHOR` (12) and `MAX_PER_GENERIC_ANCHOR` (4) and the frontloading window (first 40 entries limited to 3 per anchor) are display-density controls masquerading as data pipeline parameters.
- The net effect: 49,413 raw candidates → 250 ranked queue → 83 hub groups. This is a 99.5% reduction designed to match the rendering capacity of liveview's workbench (which shows max 12 cards per lane).
- In liveview's `QueuePairCards.tsx`, the maximum display count is 12 — matching the parser's per-anchor limit exactly.

## What Happened
The parser began shaping its output not just for correctness but for downstream rendering fitness. This is the first time in the observed ecosystem where a producer explicitly designed its output with a specific consumer's constraints in mind.

## Why It Matters
This is a maturation signal. Prior observations noted that producer diversity stresses schema contracts and that validation strength drops after discovery boundaries. This observation shows the inverse: a producer actively constraining its output to serve consumer needs. The ranking limits, bucket classifications, and drop policies are all consumer-aware quality gates built into the producer pipeline.

This also creates a coupling risk: if the workbench changes its rendering capacity (e.g., adds pagination or increases the card limit), the parser's limits become silently wrong. The limits are implicitly coupled but not declared as a contract.

## Short Pattern Explanation
When producers start shaping output for consumer rendering fitness rather than just data correctness, the system has crossed from "repos that share files" to "repos that share design constraints."
