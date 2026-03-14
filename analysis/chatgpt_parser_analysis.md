# chatGPT_parser Analysis — 2026-03-14

## Evidence Window

- **Git commits in window:** 2 (both on `main`, pushed to `origin/main`)
- **Evidence source:** `runs/2026-03-14_020436-cross-repo-delta/evidence/chatGPT_parser/`
- **Test status:** 106 passed, 3 warnings, 0 failures (pytest 9.0.2, Python 3.12.0)
- **Unstaged worktree changes:** 16 regenerated projection files (data-only, net -6,637 lines from ranking cleanup)

---

## Commit 1: Improve projection ranking hygiene (93caa02, 20:29)

### What was built

A comprehensive overhaul of the suggestion queue ranking and signal extraction systems.

**Implementation:**
- `src/chatgpt_parser/graph/extractors/signals.py` (192 lines modified) — Expanded file-reference detection heuristics. Added `COMMON_PATH_ROOTS` set, `API_ENDPOINT_PATH_RE`, `SHORT_SLASH_TOKEN_RE`, `PUNCTUATION_ONLY_RE`, `LIST_MARKER_RE`, `FILE_REFERENCE_BLACKLIST`, `SHELL_COMMAND_BLACKLIST`. Substantially refined `is_probable_file_reference()` and `is_presentable_shell_command()` to suppress false-positive path/command signals (e.g., date-like paths, API endpoints, short slash tokens, punctuation-only strings).
- `src/chatgpt_parser/projections/suggestion_queue.py` (250 lines modified) — Added `should_drop_candidate()` with explicit drop policy for unpresentable anchors. Added `canonical_anchor_key()` for path normalization. Added `classify_queue_bucket()` with 4-tier classification (`strong_operational`, `supported_anchor`, `anchor_only`, `exploratory`). Added frontloading logic: first 40 queue entries limited to 3 per anchor. Added `MAX_PER_GENERIC_ANCHOR` (4) vs `MAX_PER_ANCHOR` (12) distinction.
- `src/chatgpt_parser/projections/stable.py` (5 lines) — Minor adjustment to stable projection builder.

**Tests:**
- `tests/test_extractors/test_signals.py` — 69 new lines. Tests for the refined `is_presentable_shell_command()` and `is_probable_file_reference()` filters.
- `tests/test_projections_builder.py` — 49 lines modified.
- `tests/test_suggestion_queue.py` — 331 new lines. Comprehensive tests for queue building, ranking, bucket classification, hub suggestion generation, and the drop policy.

**Generated artifacts:**
- 6 projection data files regenerated (net reduction from 43,799 to 10,036 lines across `why_connected_candidates.ndjson`, `command_usage.ndjson`, `hub_suggestions.ndjson`, `suggestion_viewport.json`, `artifact_workflow_summary.json`, `why_connected_queue.ndjson`).

**Docs:**
- `docs/STATUS_2026-03-13_MULTIMODAL_AND_RANKING.md` — 117-line status document.

### Impact

The ranking hygiene commit dramatically reduces noise in the suggestion layer. The raw candidates went from ~49K to a ranked queue of 250 with hub groupings of 83. This is the data that flows downstream to liveview's workbench for visualization — the cleanliness of this output directly affects the signal quality in the UI.

---

## Commit 2: Add audio STT indexing and transcription pipeline (dba25b1, 23:57)

### What was built

A complete audio speech-to-text pipeline extending the parser's multimodal capabilities.

**Implementation (core):**

| File | Lines | Purpose |
|------|-------|---------|
| `src/chatgpt_parser/multimodal/audio_transcribe.py` | 605 (new) | End-to-end transcription engine |
| `src/chatgpt_parser/multimodal/audio_index.py` | 135 (modified) | Audio asset indexing with role classification |
| `src/chatgpt_parser/multimodal/transcripts.py` | 34 (modified) | Transcript linkage and matching |
| `src/chatgpt_parser/cli.py` | 57 (modified) | 3 new CLI commands |
| `src/chatgpt_parser/parser.py` | 13 (modified) | Dictation metadata extraction fixes |
| `src/chatgpt_parser/projections/builder.py` | 10 (modified) | Audio sidecar consumption in projections |
| `src/chatgpt_parser/schemas.py` | 1 (modified) | `AudioTranscriptRecord` already existed, `voice` field added to `ConversationRecord` |
| `src/chatgpt_parser/multimodal/__init__.py` | 20 (modified) | Module exports |

**CLI surface changes:**

Three new subcommands added:

1. **`transcribe-audio`** — Generates transcript sidecars from indexed audio assets.
   - `--provider` : `openai` | `local-whisper` | `faster-whisper` (normalized to `local-whisper`)
   - `--model` : default `whisper-1`
   - `--device` / `--compute-type` : for local inference
   - `--workers` : parallel CPU transcription via `ProcessPoolExecutor`
   - `--audio-id` : single-record targeting
   - `--limit` / `--overwrite` / `--only-missing` : batch control
   - `--dry-run` / `--verbose`

2. **`index-audio`** — Builds durable audio asset index from normalized records (already existed, now in CLI)

3. **`link-transcripts`** — Links external transcript files to indexed audio assets (already existed, now in CLI)

**Parser changes (`parser.py`):**
- Now prefers `dictation_asset_pointer` and `dictation_asset_format` keys from message metadata
- Boolean dictation flags no longer produce fake pointers (`"True"`, `"False"`)
- Recursive `find_dictation_payload()` searches nested metadata structures
- `voice` field now extracted from conversation records and populated in `ConversationRecord`

### Sidecar data contract

The transcript sidecar JSON schema (from `audio_transcribe.py:build_transcript_sidecar()`):

```json
{
  "schema_version": "1",
  "audio_id": "string",
  "pointer": "string",
  "resolved_path": "string",
  "source_hash": "sha256:string",
  "audio_role": "user_input | assistant_output | unknown",
  "text": "string | null",
  "segments": [{"start": float, "end": float, "text": "string"}],
  "language": "string | null",
  "duration_seconds": float,
  "confidence": float | null,
  "provider": "openai | local-whisper",
  "model": "string",
  "created_at": "ISO 8601 UTC",
  "status": "completed"
}
```

Failure sidecars include the same envelope with `status: "failed"` and an `error` field.

### Audio role classification

`classify_audio_role()` in `audio_index.py` assigns:
- `user_input` — when source kind includes `dictation`
- `assistant_output` — for `export_audio_scan` records with no `message_ids`
- `unknown` — everything else

### How audio flows into projections

The audio → projection path:

```
index-audio → audio_index.ndjson
    ↓
transcribe-audio → data/raw/transcripts/<audio_id>.json (sidecar)
    ↓
link-transcripts → data/transcripts/audio_transcripts.ndjson
    ↓
build-projections --audio-index-path --transcript-index-path
    ↓
build_typed_vs_voice(snapshot, audio_index_records, transcript_index_records)
    → typed_vs_voice.ndjson (per conversation: voice message count, audio asset count, transcript count)
    → typed_vs_voice_summary.json
    ↓
projection_validation validates audio/transcript counts are zero when no sidecars exist
```

The `build-projections` command accepts `--audio-index-path` and `--transcript-index-path` flags. These are loaded as NDJSON and passed to `build_typed_vs_voice()` which produces per-conversation modality classification records.

### Provider architecture

Two providers implemented:

1. **OpenAI** — Uses `urllib.request` directly (no SDK dependency). Calls `POST /v1/audio/transcriptions` with `response_format=verbose_json` and `timestamp_granularities[]=segment`. Requires `OPENAI_API_KEY`.

2. **local-whisper** (faster-whisper) — Optional dependency (`pip install -e .[local-stt]`). Model cached per `(model, device, compute_type)` tuple. Parallel CPU transcription via `ProcessPoolExecutor` with per-worker model caching.

### Test coverage

| Test file | Tests | Coverage |
|-----------|-------|----------|
| `tests/test_audio_transcribe.py` | 631 lines (14 tests) | Sidecar construction, candidate selection, skip logic, failure sidecars, parallel dispatch, OpenAI multipart encoding, provider normalization |
| `tests/test_audio_index.py` | 268 lines (10 tests) | Audio indexing, role classification, export scan discovery |
| `tests/test_audio_stt_smoke.py` | 97 lines (1 test) | End-to-end smoke with mock transcriber |
| `tests/test_transcript_linkage.py` | 217 lines (9 tests) | Transcript matching (audio_id, pointer, filename, stem), skip logic, create-time linkage |
| `tests/test_parser.py` | 72 lines (5 new tests) | Dictation extraction, empty conversation handling, voice field |

**Total: 106 tests pass across entire suite.**

### Pipeline stage documentation

5-stage pipeline plan documented in `pipeline/audio_stt/`:
1. `01_stage_1_transcribe_command.md` — Base transcription command
2. `02_stage_2_sidecar_contract_and_linkage.md` — Sidecar schema stability, linkage verification
3. `03_stage_3_operational_controls.md` — Batch controls, retry, limit
4. `04_stage_4_provider_integration.md` — Multi-provider support
5. `05_stage_5_validation_and_rollout.md` — End-to-end validation

### Known caveats (from `AUDIO_STT_STATUS_2026-03-13.md`)

- **GPU blocked:** CUDA runtime DLLs missing (`cublas64_12.dll`). CPU is the only reliable path.
- **Pointer resolution gap:** Many `sediment://file_<id>` pointers cannot be resolved from the export. 2,454 of 3,981 audio records have no resolved file.
- **Message ID linkage incomplete:** Export-scan `.wav` records (under `<conversation-id>/audio/`) usually have empty `message_ids`. `conversation_id` linkage is stronger.
- **Verified local batch:** 5 records transcribed successfully via `local-whisper` on CPU with `int8` precision.

---

## Worktree state (unstaged)

16 projection data files modified — these are regenerated outputs from running `build-projections` after the ranking hygiene changes. Net effect: ~6,600 fewer lines across projection outputs, reflecting the drop policy removing low-quality candidates.

Untracked files of note:
- `data/projections/projection_catalog.json` — new catalog surface manifest
- `src/chatgpt_parser/projections/catalog.py` — catalog builder module
- `archived/` — presumably old projection outputs

---

## Gaps and risks

1. **No integration test for full pipeline:** The test suite validates each stage independently (index → transcribe → link → project), but there is no end-to-end test that runs the complete chain.

2. **GPU path untested in CI:** The `local-whisper` GPU codepath exists but has never executed successfully due to missing CUDA DLLs. No test guards against GPU-specific failures.

3. **OpenAI transcription uses stdlib HTTP:** The `urllib.request.urlopen` call has a 300-second timeout but no retry logic. A transient OpenAI error will produce a failure sidecar with no automatic recovery.

4. **Projection catalog not yet committed:** `projection_catalog.json` and `catalog.py` are untracked, meaning the catalog surface that liveview's workbench relies on for structured browsing is not yet durable.

5. **`voice` field on ConversationRecord:** Added to schema but not yet validated in projection_validation checks — a conversation with `voice` set but no audio index records would not trigger a warning.
