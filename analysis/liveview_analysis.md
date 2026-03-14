# liveview/ui Analysis — 2026-03-14

## Evidence Window

- **Git commits in window:** 0 (all work uncommitted)
- **Evidence source:** `runs/2026-03-14_020436-cross-repo-delta/evidence/liveview/`, direct file reads
- **Build status:** TypeScript compiles cleanly (no errors)
- **Test status:** All tests pass (telemetry graph, projection catalog loader, session package loader, suggestion layer read-model, workbench swimlane read-model, projection catalog fixtures)
- **Build output:** Production dist generated with chunk-split bundles

---

## What was built

An entire **Projection Workbench v2** — a new tab in the liveview UI for interactive exploration of projection data emitted by chatGPT_parser.

### Scale of change

| Category | Files | Lines (approx) |
|----------|-------|----------------|
| Components | 14 new `.tsx` files | ~76K bytes |
| Read models | 7 new `.ts` files | ~40K bytes |
| Validation | 1 new `.ts` file | 933 bytes |
| Tests | 1 new `.test.cjs` file | 12,254 bytes |
| Planning docs | 7 new `.md` files | ~52K bytes |
| Modified existing | 5 files | types, loaders, vite config, package.json, tsconfig |
| New dependency | `react-resizable-panels` | — |

---

## Architecture

The workbench follows a strict 4-layer separation (documented in `plans/pipeline/workbench-v2/ARCHITECTURE.md`):

1. **Projection Contract Truth** — raw data as loaded from files
2. **Derived Read Model** — pure functions producing view-shaped models
3. **Overlay / View State** — serializable user preferences (layout, filters, selections)
4. **Render-only Presentation** — React components receiving models as props

### Component tree

```
ResearchShell                         (routing, lazy-loads WorkbenchShell)
  WorkbenchShell                      (state owner, orchestrates derivations)
    WorkbenchRibbon                   (overlay controls)
    PanelGroup [horizontal]
      CatalogBrowser                  (sidebar: surface inventory + artifact list)
      PanelGroup [vertical]
        VisualizationSurface          (main canvas)
          SwimlaneSurface → SwimlaneLane
            CandidateScoreHeatmap
            QueuePairCards
            HubCards
            GenericRecordRows
          GraphSurface                (SVG node-link diagram)
        InspectorPanel                (detail panel, 4 tabs)
```

### Data flow

```
User loads files (FileList)
  → loadSessionPackageFromFiles() parses JSON/NDJSON/MD
  → dispatch(LOAD_PROJECTION_PACKAGE) stores in app state
  → WorkbenchShell reads state.research.projectionPackage
  → useMemo chain derives read models in order:
      1. deriveWorkbenchCatalogBrowserModel(pkg)
      2. deriveWorkbenchEntityIndex(pkg)
      3. deriveWorkbenchSwimlaneModel(pkg, overlayState, entityIndex)
      4. deriveWorkbenchGraphModel(pkg, entityIndex, overlayState)
      5. deriveWorkbenchInspectorModel(pkg, entityIndex, graphModel, selectedEntity, compareEntities)
      6. deriveHighlightedEntityIds(entityIndex, hoveredOrSelectedEntity)
  → Models passed as props to presentation components
```

---

## Expected data shape

The workbench consumes the projection output files from chatGPT_parser:

**Primary input:** `projection_catalog.json` (optional but preferred)

```json
{
  "catalog_version": "string",
  "snapshot_id": "string",
  "generated_at": "ISO 8601",
  "surfaces": [
    {
      "name": "timeline.ndjson",
      "layer": "stable_projection",
      "kind": "timeline",
      "stability": "stable",
      "always_on": false,
      "depends_on": null,
      "description": "..."
    }
  ]
}
```

**Supported file types:**
- `.ndjson` — newline-delimited JSON records
- `.json` — single JSON objects
- `.md` — raw markdown text

**5 projection layers:**
- `stable_projection`
- `review_surface`
- `suggestion_layer`
- `manual_overlay`
- `continuity_inference`

**Fallback:** When no catalog is present, `loadProjectionCatalog.ts` has hardcoded `FALLBACK_SURFACE_HINTS` recognizing ~25 known filenames by pattern.

**Entity extraction:** `workbenchArtifactUtils.ts` scans records for entity references using key lists: `left`, `right`, `source`, `target`, `hub`, `label`, `name`, `node`, `artifact`, `id`, `entity`, `entity_id` (direct) and `entities`, `labels`, `nodes`, `artifacts` (array). IDs normalized via `label.trim().toLowerCase()`.

---

## What it exposes to the user

### Three layout modes
- **Swimlane** — vertical stack of lanes, one per eligible surface (requires >= 5 records and visible layer)
- **Graph** — SVG node-link diagram of entity relationships
- **Split** — both side by side

### Four specialized lane renderers
- **CandidateScoreHeatmap** — for `why_connected_candidates`: 20 score buckets (0.00-1.00) with entity chips
- **QueuePairCards** — for `why_connected_queue`: left/right pair cards with score and reason (max 12)
- **HubCards** — for `hub_suggestions`: hub label, score, support count (max 12)
- **GenericRecordRows** — fallback for any other kind: first 3 key-value pairs (max 20)

### Overlay controls (WorkbenchRibbon)
- Layer visibility toggles with per-layer surface counts
- Score threshold slider (0.00-1.00, step 0.05) — filters suggestion-layer surfaces
- Entity text filter — case-insensitive substring match, AND-composed with score threshold
- Entity isolation mode — restricts all views to an entity's neighborhood
- Selection status display
- View state save/load (JSON serialize/deserialize through `window.prompt`)

### Inspector panel (4 tabs)
- **Properties** — mention count, graph degree, surface count
- **Related** — list of related entities with mention counts
- **Raw** — raw record previews from each surface mentioning the entity (max 20)
- **Lineage** — graph edges incident to the entity

### Compare mode
Activates when exactly 2 entities are pinned/selected. Shows side-by-side entity details.

### Cross-highlighting system
- Hovering any entity propagates `hoveredEntityId` to WorkbenchShell
- `deriveHighlightedEntityIds()` expands to include related entities
- Non-highlighted items dim to opacity 0.28-0.45; highlighted items accent with teal borders (`#0f766e`)

### Graph interaction
- Pan via pointer drag
- Zoom via scroll wheel (0.4x - 3.0x)
- Double-click resets viewport
- Click/Ctrl+Click for select/multi-select

---

## Telemetry / Instrumentation

**None.** The system is entirely client-side with no network calls, no analytics events, no performance marks.

Closest to observability:
- `LoadMessage` objects (info/warning/error severity) propagated through the load pipeline
- Diagnostic counters in UI: `hiddenSurfaceCount`, `filteredOutSurfaceCount`, `eligibleSurfaceCount`
- `emptyState` discriminated unions explaining *why* a view is empty

---

## Test coverage

**One comprehensive integration test:** `tests/workbenchSwimlaneReadModel.test.cjs` (262 lines)

Covers:
- SessionPackage loading from fake `File` objects with catalog + 5 data files
- CatalogBrowser model derivation — layer counts, failure reason
- Swimlane model — lane count, renderer assignment, inspector-only classification, candidate bucket summation
- Entity index — entity count, label correctness, surface name inclusion
- Highlight derivation — transitive related entity expansion
- Graph model — node/edge existence, empty state correctness, edge kind verification
- Layer visibility filtering — hiding layers reduces lanes, updates hiddenSurfaceCount
- Score threshold filtering — threshold 0.65/0.8 reduces candidates and graph edges
- Entity text filter — filter to single match, all-filtered-out empty state
- Isolation mode — swimlane and graph both constrain to isolated entity's neighborhood
- Inspector model — entity detail, related entities, raw entries, lineage edges, compare mode
- Selection semantics — additive merge, 20-item selection limit, replacement on non-additive select
- View state validation — Zod schema acceptance/rejection

**Not tested:**
- React component rendering
- User interaction flows
- WorkbenchRibbon overlay control wiring
- Error paths (corrupt files, partial NDJSON)
- View state round-trip through `window.prompt`

---

## Gaps and risks

1. **No keyboard accessibility.** GraphSurface uses pointer events exclusively. SVG graph nodes are `<g>` elements with mouse handlers only — no keyboard focus, no ARIA roles.

2. **Linear scan performance.** `highlightedEntityIds.includes()` is O(n) per item per lane/node. Should be a `Set`.

3. **Graph layout is ring-based, not force-directed.** Nodes placed on concentric rings by degree rank. Will produce overlapping labels at scale. No collision detection.

4. **Entity ID normalization too aggressive.** `normalizeWorkbenchEntityId()` does only `trim().toLowerCase()`. Two distinct entities differing only by case will collide. The fuzzy `findBestEntityMatch()` substring matching could produce false matches.

5. **Hardcoded display limits with no pagination.** Queue/hub lanes max 12 cards, generic rows max 20, raw entries max 20, heatmap entity chips max 4 per bucket. No "show more" UI.

6. **No state persistence.** Overlay state resets on page load — not saved to localStorage or URL hash.

7. **Misleading `emptyState` naming.** When lanes exist, `emptyState` is `"notLoaded"` — misleading since data IS loaded.

8. **Duplicate score threshold logic.** Implemented separately in swimlane model (checks surface kind) and graph model (checks filename). Could drift apart.

9. **No React error boundary.** A bad artifact file causing a derivation crash will unmount the entire workbench.

10. **Build dependency:** `recharts` is bundled but not imported by any workbench component — dead weight in the workbench chunk if not used elsewhere.
