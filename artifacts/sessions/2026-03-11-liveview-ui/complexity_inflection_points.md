# Complexity Inflection Points

## 4. Architectural tensions that appeared

- State-based navigation is doing router work.
  - Evidence: `src/state/appState.tsx:18-25`, `:68-75`, `:121-173`, `src/components/research/ResearchShell.tsx:11-23`.
  - Tension: `researchView` is effectively a route enum, but there is no URL, deep link, or browser history integration.
- One app state now holds two observability models.
  - Evidence: `src/state/appState.tsx:45-56`.
  - Tension: telemetry state and research state are separated logically, but they still share one reducer, one `mode`, and one root store.
- The intended layer boundary is leaking.
  - Evidence: `src/lib/restartContext.ts:1-2` imports `isReasoningGraph` from `src/components/research/renderers/...`.
  - Tension: derivation logic depends on a component-layer renderer read model instead of a neutral contract/read-model module.
- Artifact loading is half contract inspection, half file-browser workflow.
  - Evidence: `src/components/research/SessionDetailView.tsx:72-99`.
  - Tension: the index is strict and contract-oriented, but artifact acquisition is still manual and path-blind.
- Fallback behavior is useful but currently invisible to system telemetry.
  - Evidence: `RendererMismatch` only renders inline UI; `loadSessionPackage.ts` only reports parse errors.
  - Tension: the architecture says mismatch should be observability, but the code treats it as presentation only.

## Additional complexity signals

- `loadSessionIndex.ts:36-42` uses `passthrough()` session parsing, which is good for tolerance, but it means extra fields are ignored rather than surfaced anywhere.
- `SessionListView.tsx:37-40` currently renders broken sort indicators (`?` glyphs in the working tree output), which is minor UI debt but also a sign this work is still prototype-speed.
- `loadSessionIndex.ts:38` contains an encoding artifact in the validation warning string in the current file content.

## Inference

- The next real inflection point is not rendering another artifact. It is deciding whether research artifacts are first-class contracts with shared schemas or just file-shaped hints interpreted by the UI.
