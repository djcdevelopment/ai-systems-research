# Question

## Core Question
How should Liveview codify observability read models (coverage, type vocab, package health, reasoning graph stats, cross-session windows, timeline buckets) as explicit contracts so that artifact-led workflows can reuse them across sessions and systems without re-implementation?

## Why This Matters
Observability is now a first-class architectural layer. Standardizing the read models would let research tooling and alerts plug into the same projections that power the UI, reduce regression risk (e.g., timezone grouping), and make cross-session insights portable.

## Subquestions
- Should `SESSION_LOG.jsonl` include an explicit timezone policy and session-local offset to prevent future bucket drift?
- Are coverage thresholds, type icon fallbacks, and package health aggregation rules contract material or implementation detail?
- How can derived projections (graph shape extraction, cross-session histograms) be emitted as artifacts alongside the raw session log so other consumers do not rebuild them?
- What cache/window parameters should be standardized to keep cross-session dashboards consistent and predictable?
- If observability is a layer, should it expose alert hooks (coverage drop, orphan spike) as part of the contract instead of UI-only signals?

## Related Artifacts
- research/observations/2026-03-11-liveview-ui-observability-lessons.md
- research/observations/2026-03-11-liveview-ui-complexity-inflection-points.md
- research/observations/2026-03-11-liveview-ui-context-reduction-strategy.md
- research/snapshots/2026-03-11-liveview-ui-observability-system-snapshot.md
- research/synthesis/2026-03-11-liveview-observability-architecture-layer.md
