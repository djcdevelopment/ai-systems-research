# Lesson Learned

## 1. What today proved about viability

- Verified: the split-shell model is viable for a debugger-style UI.
  - Evidence: `src/App.tsx:64-84`, `src/components/shell/AppShell.tsx:13-25`, `src/components/research/ResearchShell.tsx:11-23`.
  - The research track can bootstrap independently from load mode while telemetry keeps its existing chrome and views.
- Verified: `SESSION_LOG.jsonl` works as a practical strict boundary for session discovery.
  - Evidence: `src/data/loadSessionIndex.ts:27-50`, `src/validation/researchSchemas.ts:7-17`.
  - Invalid lines are skipped with warnings instead of poisoning the whole session index.
- Verified: renderer-local tolerant interpretation is workable for artifact payloads.
  - Evidence: `src/components/research/renderers/RequestLogRenderer.tsx:43-98`, `src/components/research/renderers/ReasoningGraphRenderer.tsx:81-114`.
  - The UI can still render useful structure while preserving unknown fields and falling back to raw JSON.
- Verified: restart-context derivation is feasible as a representational debugger feature rather than a workflow engine.
  - Evidence: `src/lib/restartContext.ts:107-143`, `src/components/research/RestartContextView.tsx:21-115`.
  - The implementation already emits provenance and warnings instead of pretending derivation is always complete.

## 2. What remains soft or underspecified

- Verified: artifact envelopes are not validated at load time.
  - Evidence: `src/types/research.ts:34-45`, `src/data/loadSessionPackage.ts:31-87`.
  - `SessionArtifact` only guarantees filename, derived key, media type, and `unknown` content.
- Verified: the contract between session index artifact paths and actual file resolution is still manual.
  - Evidence: `src/components/research/SessionDetailView.tsx:72-99`.
  - The UI displays artifact paths from the index, but artifact loading still depends on manual file selection.
- Verified: renderer mismatch handling is a UI fallback, not telemetry.
  - Evidence: `src/components/research/renderers/RendererMismatch.tsx`, `RequestLogRenderer.tsx:44-50`, `ReasoningGraphRenderer.tsx:82-88`.
- Inference: artifact schema versioning, envelope metadata, and provenance fields are likely still undecided outside the UI because no shared schema is enforced here.

## 3. Where the current implementation is overfitting

- Verified: artifact key derivation is hardcoded to a small filename list.
  - Evidence: `src/data/loadSessionPackage.ts:8-20`.
- Verified: the request-log read model assumes current field names such as `request_id`, `prompt_summary`, and `tokens_used`.
  - Evidence: `src/components/research/renderers/requestLogReadModel.ts:1-20`, `RequestLogRenderer.tsx:31-39`.
- Verified: the reasoning-graph read model assumes `root_nodes`, `node_id`, `parent`, `children`, and `evidence`.
  - Evidence: `src/components/research/renderers/reasoningGraphReadModel.ts:1-20`, `ReasoningGraphRenderer.tsx:20-33`, `:95-110`.
- Verified: restart-context derivation assumes a specific artifact set and specific filenames.
  - Evidence: `src/lib/restartContext.ts:111-132`.
- Inference: this is acceptable for a debugger prototype, but it will become brittle as soon as multiple producers or schema revisions exist.
