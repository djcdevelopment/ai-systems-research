# Lesson Learned

## What Happened
- `chatGPT_parser` emitted `projection_catalog.json` without `generated_at` while `liveView/ui` treated `generated_at` as required in its strict schema.
- `liveView/ui` had two behaviors for the same artifact: Workbench validated `projection_catalog.json` before use, while Observatory read the same file as unvalidated JSON.
- The fix was applied on both sides of the boundary:
- producer: `D:\work\chatGPT_parser\src\chatgpt_parser\projections\catalog.py` now publishes `generated_at`, sourced from `graph_manifest.json` in `D:\work\chatGPT_parser\src\chatgpt_parser\projections\builder.py`
- consumer: `D:\work\liveView\ui\src\data\loadObservatoryData.ts` now uses the same projection catalog parser as Workbench, and `D:\work\liveView\ui\src\validation\projectionCatalogSchemas.ts` remains backward-tolerant for older catalogs
- Verification completed with `npm test`, `npm run build`, focused parser projection tests, and the full parser pytest suite.

## What Worked
- Using `graph_manifest.build_time` as the source for catalog `generated_at` kept producer metadata deterministic for a given graph snapshot.
- Routing both Workbench and Observatory through the same parser removed one of the main drift vectors inside `liveView/ui`.
- Adding a targeted Observatory loader test covered the previously unvalidated path without broadening the UI surface area.
- Keeping the UI schema tolerant of missing `generated_at` preserved compatibility with older catalogs while the producer catches up.

## What Failed
- The original contract lived more in code assumptions than in an explicit shared document.
- A fallback path in the UI had accumulated local `kind` aliases that did not fully match producer vocabulary.
- Earlier verification was incomplete because one consumer path was not using the same schema gate as the other.

## Reusable Takeaway
- When a produced index is intended to be authoritative, publish deterministic provenance metadata at the producer and force every consumer entry point through one parser.
