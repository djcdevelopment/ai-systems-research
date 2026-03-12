# Lesson Learned

## Observability must precede analysis

Attempting to build analysis before reliable artifact capture increases cognitive overhead and drift.

The correct sequence is:

observability ? artifacts ? indexing ? research

## Cold start is the real productivity killer

The largest friction in long-running systems work is not complexity itself but re-entry cost.

START_HERE.md + SESSION_LOG.jsonl reduce restart cost to two files.
