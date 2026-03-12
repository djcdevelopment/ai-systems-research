# System Snapshot

- Inputs: `SESSION_LOG.jsonl` remains the canonical index for discovery events; ingestion normalizes timestamps in UTC.
- Derived read models: coverage by artifact contract, type vocabulary map, validation-derived package health, reasoning-graph shape stats, cross-session frequency and coverage distributions, and session timeline buckets.
- UI slices: session table with coverage indicator and type icons; artifact detail with package health; reasoning graph diagnostics panel; cross-session insights dashboard; timeline grouped by day with date-range summary and corrected timezone alignment.
- Posture: the UI now functions as a debugging instrument panel—each slice exposes actionable signals rather than passive views, exemplified by the timezone grouping bug caught via timeline observability.
