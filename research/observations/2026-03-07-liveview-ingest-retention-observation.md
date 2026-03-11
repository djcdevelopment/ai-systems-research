# Observation

## Title
liveview ingest appears to retain partially structured records rather than dropping them

## Context
- system_id: liveview
- source system path: D:\work\liveView
- evidence scope: latest available ingest snapshot artifacts in `ingest/out`

## Evidence
- `D:\work\liveView\ingest\out\summary.json`
  - `generatedAt`: `2026-03-07T04:09:52.860Z`
  - `recordsParsed`: `16`
  - `errors`: `0`
  - `warnings`: `0`
- `D:\work\liveView\ingest\out\inventory.json`
  - record counts by file: `1` (`config/settings.json`) + `5` (`logs/app.jsonl`) + `10` (`logs/debug.log`) = `16`
- `D:\work\liveView\ingest\out\events.json`
  - multiple `logs/debug.log` records include `timestamp: null` and `flow/stage/status: "unknown"`
  - these records are still present in the emitted event stream

## Observation
From the latest artifacts, ingest retained all parsed records (including records with missing timestamps and unknown classification fields) in `events.json`.

## Interpretation
Provisional interpretation: `liveview` ingest is currently favoring loss-minimizing retention with explicit unknown fields over strict filtering.

## Open Questions
- Is this retention behavior intentional policy or a temporary implementation state?
- Should retention of partially structured events be configurable by mode (for example, strict vs. permissive)?
