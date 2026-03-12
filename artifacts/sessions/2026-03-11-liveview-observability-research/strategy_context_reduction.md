# Strategy: Context Reduction

- Treat `SESSION_LOG.jsonl` as the single discovery index; all slices consume derived read models rather than raw logs to keep UI state lean.
- Use artifact contracts to bound reasoning: coverage, validation health, and type icons derive only from contract-defined artifacts, preventing scope creep.
- Partition observability by slice (coverage, type scanability, package health, graph diagnostics, cross-session insights, timeline) so each view depends on a minimal, purpose-built projection.
- Normalize time at ingestion (UTC) and render in user context to avoid leaking timezone decisions through the UI surface.
- Favor incremental instrumentation: add the smallest metric that explains current uncertainty, validate, then expand (example: timeline bug fixed once day buckets were surfaced).
