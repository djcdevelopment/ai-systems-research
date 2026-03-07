# Experiment

## Hypothesis
If model responsibilities are separated by bounded system ownership, collaboration quality will improve and implementation will become easier to steer.

## Setup
System: liveView

Two model roles were used in practice:
- ingest-focused implementation
- UI-focused implementation

The intended rule was:
- ingest owns truth
- UI owns interpretation

## Inputs
- repo structure with separate ingest and UI folders
- contract documents defining context and snapshot expectations
- active implementation sessions
- test suite for ingest

## Constraints
- fast iteration during active building
- no attempt to solve everything through a single model context
- preference for explicit interfaces over hidden parsing logic

## Outcome
The system became easier to reason about once responsibilities were clearly bounded.
Tests made it safer to let implementation move quickly.
The resulting shape was more stable than a prompt-centric workflow.

## Interpretation
The useful abstraction may be closer to team topology or distributed systems design than to “better prompting.”
Models appear to collaborate better when scope, ownership, and interfaces are real.

## Follow-ups
- capture exact ingest test evidence in a snapshot artifact
- compare this approach against a single-model workflow
- test whether research artifacts improve downstream synthesis quality
