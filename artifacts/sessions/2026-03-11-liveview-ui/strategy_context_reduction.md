# Strategy: Context Reduction

## 6. Likely next implementation step

- The next step should be to formalize the artifact envelope boundary before adding more specialized renderers.

## Why this is the next step

- Verified: session discovery already has a strict validated boundary via `SESSION_LOG.jsonl`.
  - Evidence: `src/data/loadSessionIndex.ts:36-42`, `src/validation/researchSchemas.ts:7-17`.
- Verified: artifact loading does not yet have an equivalent boundary.
  - Evidence: `src/data/loadSessionPackage.ts:31-87`.
- Verified: restart-context derivation and renderer dispatch both depend on filename-derived `artifactKey`, not on validated envelope metadata.
  - Evidence: `src/data/loadSessionPackage.ts:8-20`, `src/components/research/renderers/ArtifactRenderer.tsx:11-19`, `src/lib/restartContext.ts:111-132`.

## Recommended implementation slice

1. Add a strict artifact envelope schema and validate every JSON artifact at load time.
2. Move read-model guards out of `components/` into a neutral `contracts/` or `read-models/` layer.
3. Emit renderer mismatch events into research load messages or a dedicated diagnostics panel.
4. Add artifact resolution from indexed paths or a manifest, so the UI stops depending on manual file picking.

## Expected payoff

- This reduces ambiguity at the contract boundary.
- It preserves the debugger stance: strict envelope, tolerant payload interpretation, explicit mismatch reporting.
- It will make future renderers cheaper because they can rely on a consistent envelope and provenance model.
