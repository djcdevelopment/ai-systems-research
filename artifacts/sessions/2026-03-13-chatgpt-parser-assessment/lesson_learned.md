# Lesson Learned

## What Happened
- Inspecting `chatGPT_parser` in ecosystem context showed that the repo has already moved beyond simple export parsing.
- It now implements a layered evidence pipeline:
  - normalized records
  - canonical graph
  - multimodal sidecars
  - stable projections
  - manual overlay hooks
- Cross-repo comparison showed strong philosophical alignment with `ai-dev-system` and `liveView`, but no shared handoff contract yet.

## What Worked
- Artifact-first design made the repo legible quickly.
- Tests were strong enough to distinguish implemented behavior from plan-only intent.
- Multimodal separation rules were explicit and consistently reinforced by tests and docs.
- Manifests and deterministic file outputs made architectural intent easy to infer.

## What Failed
- Repo-local contracts outpaced ecosystem contracts.
- Architectural state documents drifted: `PLAN4.md` and `ARCHITECTURE_STATE.md` disagree on image/OCR graph status.
- The presence of schemas suggested stronger runtime guarantees than the inspected code actually enforces.
- There is still no direct consumer contract tying parser outputs into `liveView` or research packaging.

## Reusable Takeaway
- Artifact-driven development scales best when producer-specific pipelines are paired early with explicit cross-repo handoff contracts; otherwise capability grows faster than interoperability.

## What This Suggests About Artifact-Driven Development
- Done well:
  - build durable layers first
  - keep modalities separated
  - make projections disposable
  - preserve provenance everywhere
- Needs tightening before scaling:
  - shared system identity
  - bundle-level versioning
  - runtime contract enforcement
  - explicit consumer contracts

## What Was Done Well Tonight
- The parser repo was assessed from code and tests first, not from README claims alone.
- Implemented, scaffolded, and inferred states were separated instead of collapsed.
- Cross-repo fit was evaluated as a contract problem, not only a feature checklist problem.

## What Should Be Tightened Before Scaling
- Register the repo formally in research contracts.
- Define how parser outputs are meant to be consumed.
- Unify manifest/version conventions with the rest of the ecosystem.
- Resolve doc drift so architectural state is trustworthy at a glance.
