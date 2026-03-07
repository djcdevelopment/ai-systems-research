# Synthesis

## Angle
AI systems become more dependable when built like bounded engineering systems rather than treated like prompt-driven magic.

## Source Artifacts
- research/observations/2026-03-07-contracts-and-tests-stabilize-models.md
- research/experiments/2026-03-07-multi-model-boundary-test.md
- research/questions/2026-03-07-architecture-over-prompts.md
- research/snapshots/2026-03-07-liveview-first-research-state.md

## Emerging Pattern
The strongest gains did not come from better wording in prompts.
They came from explicit ownership, stable contracts, test coverage, and a clean separation between truth generation and interpretation.

## Tensions / Counterpoints
- This may partially reflect the specific strengths of the models used.
- The result may be strongest in code-heavy environments where interfaces can be made concrete.
- More comparison is needed against a less-structured workflow.

## Candidate Claims
- Explicit contracts outperform prompt cleverness in multi-model implementation.
- Tests become governance when AI participates in building.
- Deterministic snapshots create a safe seam between system truth and interpretive UI layers.
- Model collaboration improves when responsibilities resemble team boundaries.

## Possible Narrative Shapes
- article: architecture beats prompts
- post: what surprised me after separating model responsibilities
- memo: research notes on bounded AI implementation
- talk: building AI systems like engineering teams
