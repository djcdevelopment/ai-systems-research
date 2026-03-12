# System Snapshot

## Evidence Base

- Verified: the only committed UI history from today is the baseline milestone commit `cd2e818`; the research UI work itself is primarily present in the current working tree (`git log --since="2026-03-11 00:00"` and `git status --short`).
- Verified: the research work is confined to the UI repo and UI-layer files under `src/`.

## Verified Observations

- A parent shell split between telemetry and research exists.
  - `src/components/shell/TrackToggle.tsx:4-23` introduces `Runs / Telemetry` vs `Sessions / Research`.
  - `src/App.tsx:64-84` and `src/components/shell/AppShell.tsx:13-25` switch the top-level shell based on `state.activeTrack`.
- Telemetry behavior was preserved rather than merged into research.
  - `src/components/shell/AppShell.tsx:28-55` keeps a dedicated telemetry shell with `TopBarSummary`, telemetry-only tabs, and the existing explorer/timeline/inspector views plus `runMap`.
  - `src/components/shell/ViewTabs.tsx:11-27` only exposes telemetry views.
- Research session discovery is loaded from `SESSION_LOG.jsonl`.
  - `src/components/research/SessionLoader.tsx:19-33` prompts for `SESSION_LOG.jsonl`.
  - `src/data/loadSessionIndex.ts:10-51` parses JSONL line-by-line and validates each line with `sessionEntrySchema`.
  - `src/validation/researchSchemas.ts:7-17` defines the strict discovery boundary for `session_id`, `timestamp`, `system_id`, `status`, `summary`, `artifacts`, and `open_threads`.
- A research session list and detail view exist.
  - `src/components/research/ResearchShell.tsx:11-23` switches among loader, session list, session detail, and restart-context views.
  - `src/components/research/SessionListView.tsx:22-94` renders the session table.
  - `src/components/research/SessionDetailView.tsx:36-130` renders session metadata and artifact inspection.
- Research session filters were added.
  - `src/components/research/SessionListFilters.tsx` defines text, status, system, and open-thread filtering.
  - `src/state/selectors.ts:75-119` applies filtering and sorting in the renderer process.
- Artifact file loading and inline display exist.
  - `src/components/research/SessionDetailView.tsx:86-123` loads `.md` and `.json` files manually.
  - `src/data/loadSessionPackage.ts:31-87` reads files and parses JSON when possible.
  - `src/components/research/renderers/ArtifactRenderer.tsx:6-19` chooses markdown text, raw JSON, or specialized renderers.
- Renderer-local read models exist for `request_log.json` and `session_reasoning_graph.json`.
  - `src/components/research/renderers/requestLogReadModel.ts:11-20`
  - `src/components/research/renderers/reasoningGraphReadModel.ts:11-20`
- Tolerant structured renderers exist and degrade to raw JSON on mismatch.
  - `src/components/research/renderers/RequestLogRenderer.tsx:43-98`
  - `src/components/research/renderers/ReasoningGraphRenderer.tsx:81-114`
  - Both normalize partial rows/nodes and expose unknown fields via `extra`.
- Restart-context view and derivation logic exist.
  - `src/components/research/RestartContextView.tsx:21-115`
  - `src/lib/restartContext.ts:107-143` derives warnings, provenance (`derivedFrom`), unresolved threads, last snapshot, and reasoning path.

## Architecture Fit

- Supported:
  - `SESSION_LOG.jsonl` is treated as a strict validated discovery boundary.
  - Telemetry/run observability remains separate from research/session observability in the shell and tab structure.
  - Renderer-local tolerant read models are being used for structured display.
- Only partially supported:
  - There is a restart-context view, but not a real route. Navigation is state-based (`researchView`) rather than URL-based.
  - Renderer mismatches are surfaced in the UI via `RendererMismatch`, but they are not recorded as telemetry or load diagnostics.
- Not yet supported:
  - Strict artifact envelope validation is not implemented. `loadSessionPackage.ts` accepts raw JSON by filename/media type and passes `unknown` payloads directly to renderers.
  - The explicit three-stage fallback described in the target architecture is missing the first stage. Current behavior is effectively:
    - parse JSON if possible
    - try renderer read model
    - show raw JSON on mismatch

## Inference

- The prototype proves the research UI can live alongside telemetry without collapsing the existing observability UI, but it also shows that the artifact boundary needs another formal layer before the model is stable.
