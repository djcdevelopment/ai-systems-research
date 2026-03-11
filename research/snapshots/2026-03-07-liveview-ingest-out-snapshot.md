# Snapshot

## State Summary
Latest observed `liveview` ingest output bundle was generated at `2026-03-07T04:09:52.860Z` with zero reported ingest errors/warnings.

## Relevant Modules
- system_id: liveview
- ingest artifact output path: `D:\work\liveView\ingest\out`
- contract references:
  - `D:\work\liveView\PROJECT_CONTEXT.md`
  - `D:\work\liveView\SNAPSHOT_CONTRACT.md`
  - `D:\work\liveView\RESEARCH_LINK.md`

## Metrics
- files scanned: `3`
- records parsed: `16`
- errors: `0`
- warnings: `0`
- source file mix:
  - `config/settings.json` (`json`, `recordCount: 1`)
  - `logs/app.jsonl` (`jsonl`, `recordCount: 5`)
  - `logs/debug.log` (`text-log`, `recordCount: 10`)
- edges emitted: `2` (`trace-abc -> logs/app.jsonl`, `trace-def -> logs/app.jsonl`)
- series summary:
  - `eventsPerMinute`: `8` at `02:10`, `2` at `02:11`, `1` at `02:12`
  - `errorsPerMinute`: empty

## Notable Changes
- The latest available artifacts are in `ingest/out` and align with the file set described in `SNAPSHOT_CONTRACT.md`.
- `RESEARCH_LINK.md` and `SYSTEM_INDEX.md` reference `artifacts/sessions/`; this path was not observed in the inspected `liveview` working tree at this time.

## Attached Evidence
- `D:\work\liveView\ingest\out\schema-version.json`
- `D:\work\liveView\ingest\out\summary.json`
- `D:\work\liveView\ingest\out\inventory.json`
- `D:\work\liveView\ingest\out\events.json`
- `D:\work\liveView\ingest\out\edges.json`
- `D:\work\liveView\ingest\out\series.json`
- `D:\work\liveView\ingest\out\diagnostics.json`
