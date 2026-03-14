# System Snapshot

## Components
- `chatGPT_parser` is a Python `src/`-layout CLI pipeline with repo-root shims at `chatgpt_parser/__main__.py` and main implementation under `src/chatgpt_parser/`.
- Implemented stages:
  - ingest: `src/chatgpt_parser/ingest.py`, `src/chatgpt_parser/parser.py`
  - graph build: `src/chatgpt_parser/graph/builder.py`
  - multimodal sidecars: `src/chatgpt_parser/multimodal/`
  - projections: `src/chatgpt_parser/projections/`
  - overlays: `src/chatgpt_parser/overlays/`
- Declared JSON Schemas exist under `schemas/` for core records and overlay records.
- Test surface is substantial: `python -m pytest` passed `47` tests on 2026-03-13.

## Data Flow
- Raw ChatGPT export files named `conversations-*.json`
  ->
  normalized NDJSON (`messages.ndjson`, `conversations.ndjson`, `source_files.ndjson`, `ingest_manifest.json`)
  ->
  canonical graph (`nodes.ndjson`, `edges.ndjson`, `graph_manifest.json`)
  ->
  stable projections (`timeline.ndjson`, `artifact_index.ndjson`, `search_index.ndjson`, `typed_vs_voice.ndjson`, `lineage_views.ndjson`, etc.)
  ->
  optional in-memory overlay application for selected projections.
- Multimodal side flow:
  - normalized messages -> audio/image pointer discovery
  - external transcript/OCR/semantics directories -> matched durable sidecars
  - sidecars -> additive graph/projection augmentation

## Artifact Contracts
- Implemented durable artifacts in `chatGPT_parser` are NDJSON/JSON files under `data/normalized/`, `data/graph/`, `data/assets/`, `data/transcripts/`, `data/ocr/`, `data/images/`, and `data/projections/`.
- Core dataclass record contracts are in `src/chatgpt_parser/schemas.py`.
- Optional header/meta records are supported for durable sidecars via `_record_type: "index_meta"` in `src/chatgpt_parser/writer.py`.
- `graph_manifest.json` and `snapshot_manifest.<snapshot_id>.json` provide build metadata, counts, and fingerprints.
- Important gap: declared JSON schemas in `schemas/` are not obviously enforced at runtime. Inference based on code search: record creation is dataclass-driven, but no JSON Schema validator is wired into ingest/build commands.

## Key Files
- `README.md`
- `ARCHITECTURE_STATE.md`
- `PLAN_FLOW.md`
- `PLAN4.md`
- `src/chatgpt_parser/cli.py`
- `src/chatgpt_parser/ingest.py`
- `src/chatgpt_parser/parser.py`
- `src/chatgpt_parser/graph/builder.py`
- `src/chatgpt_parser/projections/builder.py`
- `src/chatgpt_parser/projections/snapshot_manifest.py`
- `src/chatgpt_parser/multimodal/*.py`
- `tests/test_ingest.py`
- `tests/test_graph_builder.py`
- `tests/test_projections_builder.py`

## What It Currently Is
- Already implemented:
  - export ingest for ChatGPT conversation dumps
  - canonical-path-aware message normalization
  - graph construction with extractors for entities, commands, artifacts, topics, phase, intent, and signals
  - durable audio index and transcript linkage
  - durable image index, OCR linkage, and image semantics linkage
  - additive graph augmentation for audio/transcripts/images/OCR
  - stable projections for search, classification, command usage, image evidence, typed-vs-voice, and lineage
  - overlay loading and in-memory projection patching
- Scaffolded but incomplete:
  - image semantics as a durable sidecar exists, but graph/projection use is minimal; current use appears limited to snapshot-manifest counting.
  - overlay infrastructure exists, but there is no bundled review/UI workflow in this repo.
- Implied by docs/plans:
  - this is evolving toward a research-grade multimodal artifact corpus, not just a one-off export parser.

## Current CLI Surface
- `ingest`
- `build-graph`
- `build-projections`
- `index-audio`
- `link-transcripts`
- `index-images`
- `link-image-ocr`
- `link-image-semantics`

## Current Architectural Shape
- Layered and artifact-first.
- Deterministic file emission is treated as a core invariant.
- Canonical text and additive multimodal evidence are intentionally separated.
- Graph is positioned as the canonical integration layer.
- Projections are treated as disposable derived views.
- Overlays are treated as a manual correction layer that must not mutate canonical artifacts.

## Notable Strengths
- Strong implementation/test alignment. `47` passing tests cover ingest, graph, multimodal linkage, projections, and overlays.
- Explicit handling of ChatGPT export quirks:
  - canonical path derivation from `mapping` + `current_node`
  - hidden messages
  - branching conversations
  - dictation pointers
  - multiple content types including `multimodal_text`, `thoughts`, `reasoning_recap`, and `tether_browsing_display`
- Good durability posture:
  - manifests
  - fingerprints and input hashes
  - dry-run modes
  - deterministic ordering
  - provenance-preserving additive multimodal edges
- Architectural intent is unusually explicit for an early repo.

## Notable Gaps
- No explicit source-system contract file analogous to `RESEARCH_LINK.md` or `SNAPSHOT_CONTRACT.md`.
- Output contract is repo-local rather than ecosystem-standard.
- `liveView` cannot consume parser outputs directly without an adapter or a new snapshot contract.
- `ai-systems-research` session packaging conventions are not yet represented in parser outputs.
- Runtime schema enforcement appears incomplete despite the presence of `schemas/*.json`.
- `ARCHITECTURE_STATE.md` and `PLAN4.md` disagree on image/OCR graph augmentation status, so architectural state is partially stale.
- `graph_manifest.json` captures warning counts but not detailed warning payloads.

## Notes
- The repo looks like a serious parser-plus-evidence-pipeline prototype, not a thin ETL script.
- Strong inference: its likely end state is a durable multimodal conversation corpus suitable for graph construction, replayable projections, and downstream research/UI consumption.
