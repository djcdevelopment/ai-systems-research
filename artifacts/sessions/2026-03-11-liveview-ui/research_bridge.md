# Research Bridge

## 5. Product and system requirements becoming visible

- Verified: the prototype needs a real artifact resolution mechanism.
  - Evidence: `src/components/research/SessionDetailView.tsx:72-99`.
  - Requirement: given a session entry, the UI should be able to resolve and load its artifact set without manual selection.
- Verified: the prototype needs a first-class diagnostics surface for renderer mismatches and derivation warnings.
  - Evidence: `src/components/research/renderers/RendererMismatch.tsx`, `src/components/research/RestartContextView.tsx:103-114`.
  - Requirement: contract drift should be queryable and countable, not just visible inline.
- Verified: the prototype needs a shared artifact contract layer.
  - Evidence: `src/lib/restartContext.ts:1-2` and renderer guards under `src/components/research/renderers/`.
  - Requirement: renderer-local read models can stay local, but envelope schemas and core derived models should not live under UI components.
- Verified: the prototype needs URL-addressable research views if it is going to support real debugging workflows.
  - Evidence: `src/state/appState.tsx:18-25`, `:121-173`, `src/components/research/ResearchShell.tsx:15-23`.
  - Requirement: session detail and restart context likely need deep links.
- Inference: once more artifact types arrive, the current filename-switch dispatch model will become expensive to maintain unless artifact capabilities are declared in metadata.

## Answer to the architecture question

- The current code supports the intended architecture in one area strongly: strict session discovery plus separate research/telemetry shells.
- It supports the intended architecture in one area partially: tolerant renderer-local payload interpretation.
- It does not yet support the intended architecture in the most important missing area: strict artifact envelope validation and telemetry for renderer mismatch.

## Bottom line

- This prototype is a viable representational debugger.
- It is not yet a stable artifact-contract debugger, because artifact identity and validation still depend too heavily on filenames and renderer guesses.
