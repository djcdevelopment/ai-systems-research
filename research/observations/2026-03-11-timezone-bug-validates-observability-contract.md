# Observation

## Title
Timeline timezone bug shows contract-bound observability acting as a debugging instrument, not just a viewer.

## Context
The Liveview session timeline slice groups `SESSION_LOG.jsonl` events by day. Timestamps are normalized to UTC at ingestion and rendered in the user's local context. Observability slices share derived read models (coverage, type vocab, package health, graph diagnostics) bounded by artifact contracts.

## Evidence
- research/observations/2026-03-11-liveview-ui-observability-lessons.md: timeline slice uncovered UTC vs local day grouping mismatch and guided the fix.
- research/observations/2026-03-11-liveview-ui-complexity-inflection-points.md: day-grouping fix forced explicit timezone handling to eliminate off-by-one regressions.
- research/observations/2026-03-11-liveview-ui-context-reduction-strategy.md: strategy mandates UTC ingestion with local rendering and incremental instrumentation after surfacing day buckets.
- research/snapshots/2026-03-11-liveview-ui-observability-system-snapshot.md: current UI now shows day-grouped timeline with corrected timezone alignment.

## What Happened
When the timeline slice began showing day buckets, mis-bucketed events revealed that UTC-normalized logs were being grouped without adjusting to the session's local context. Because the timeline was instrumented as a first-class slice, the defect was visible to the operator and quickly fixed by aligning grouping to local time while keeping ingestion in UTC.

## Why It Matters
- Instruments expose contract violations that would stay silent in a passive viewer, validating the value of observability as architecture.
- Time handling is a cross-slice contract; catching the bug through the timeline prevented downstream drift in coverage, cross-session insights, and graph diagnostics.
- This demonstrates that surfacing even small derived metrics (day buckets) can close the loop between raw logs and contract health.

## Open Questions
- Should timezone expectations be codified directly in the research/implementation contract to prevent future drift?
- How can timeline bucket tests be automated from `SESSION_LOG.jsonl` so regressions are caught before UI exposure?
- Are there other cross-cutting contracts (e.g., artifact type vocab, health thresholds) that should be validated through similar instrumented slices?
