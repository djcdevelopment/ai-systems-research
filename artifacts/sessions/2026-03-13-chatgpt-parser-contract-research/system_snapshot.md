# System Snapshot

## Components

- `src/chatgpt_parser/ingest.py`: Phase 1 ingest orchestration for `conversations-*.json` exports into normalized NDJSON.
- `src/chatgpt_parser/parser.py`: conversation/message flattening, canonical-path handling, provenance capture, and ingest-time warnings.
- `src/chatgpt_parser/graph/builder.py`: canonical evidence graph builder, graph manifest emission, warning triage hookup, multimodal node/edge augmentation.
- `src/chatgpt_parser/projections/builder.py`: stable projection orchestration and projection-side review/suggestion artifact emission.
- `src/chatgpt_parser/multimodal/`: durable sidecar builders for audio, transcripts, images, OCR, and image semantics.
- `src/chatgpt_parser/projections/catalog.py`: machine-readable projection layer catalog for downstream consumers.
- `tests/`: 63-test suite covering parser, ingest, graph, multimodal, overlays, and projection outputs.

## Data Flow

- Raw export dump (`D:\work\dump`) -> normalized evidence:
  - `data/normalized/messages.ndjson`
  - `data/normalized/conversations.ndjson`
  - `data/normalized/source_files.ndjson`
- Normalized evidence -> multimodal sidecars:
  - `data/assets/image_index.ndjson`
  - `data/assets/audio_index.ndjson`
  - `data/transcripts/audio_transcripts.ndjson`
  - `data/ocr/image_ocr.ndjson`
  - `data/images/image_semantics.ndjson`
- Normalized evidence + sidecars -> canonical graph:
  - `data/graph/nodes.ndjson`
  - `data/graph/edges.ndjson`
  - `data/graph/graph_manifest.json`
  - `data/graph/graph_warning_triage.json`
- Graph + sidecars -> projections and review surfaces:
  - stable projections such as `timeline.ndjson`, `artifact_index.ndjson`, `decision_trace.ndjson`
  - review surfaces such as `projection_validation.json`, `operator_attention_queue.ndjson`
  - suggestion surfaces such as `why_connected_queue.ndjson`, `hub_suggestions.ndjson`, `projection_catalog.json`

## Artifact Contracts

- Evidence is durable and provenance-preserving; raw source dumps remain outside canonical outputs.
- Multimodal sidecars are additive and modality-separated; typed text is not merged with transcript or OCR text before extraction.
- Graph outputs are canonical derived structure with manifest and warning triage sidecars.
- Projections are rebuildable read models; current downstream discovery contract is `data/projections/projection_catalog.json`.
- First-run hardening sidecars include:
  - `data/projections/snapshot_manifest.first_full_dataset.json`
  - `data/projections/projection_validation.json`
  - `data/projections/pipeline_report.first_full_dataset.json`

## Key Files

- `README.md`
- `docs/architecture/CURRENT_ARCHITECTURE_OVERVIEW.md`
- `src/chatgpt_parser/cli.py`
- `src/chatgpt_parser/graph/builder.py`
- `src/chatgpt_parser/projections/builder.py`
- `src/chatgpt_parser/projections/catalog.py`
- `data/graph/graph_manifest.json`
- `data/graph/graph_warning_triage.json`
- `data/projections/snapshot_manifest.first_full_dataset.json`
- `data/projections/projection_validation.json`
- `data/projections/projection_catalog.json`
- `tests/test_graph_builder.py`
- `tests/test_projections_builder.py`
