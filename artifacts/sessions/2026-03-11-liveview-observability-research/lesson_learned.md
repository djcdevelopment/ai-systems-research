# Lessons Learned

- Observability slices turn the LiveView UI from a passive viewer into a debugging instrument panel by exposing artifact coverage, type scanability, package health, graph diagnostics, cross-session trends, and session timelines.
- Anchoring all discovery on `SESSION_LOG.jsonl` keeps data lineage explicit and makes derived read models reproducible and debuggable.
- Artifact contracts are the correct system boundary: contract-driven indicators (coverage, validation health, type icons) stayed stable while views evolved.
- Incremental slice delivery preserved momentum—each slice shipped with just enough derived data to validate value before widening scope.
- The UTC vs local timeline grouping bug illustrated observability payback: surfacing day-grouped summaries quickly revealed mis-bucketed events and guided the fix.
