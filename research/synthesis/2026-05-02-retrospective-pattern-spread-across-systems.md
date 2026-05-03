# Synthesis: Retrospective practice spreads beyond its source repo

## Angle

The retrospective/lesson_learned artifact pattern this hub was designed to formalize has been adopted independently by 11+ implementation repos under `D:\work`, in three distinct evolutionary forms — literal schema reuse, structural maturation past the source contract, and formal architectural decisions about retro behavior. The hub itself has had no visibility into most of this output.

## Source Artifacts (sampled, not exhaustive)

- `D:\work\writing\artifacts\sessions\2026-04-09-bootstrap\lesson_learned.md`
- `D:\work\writing\artifacts\sessions\2026-04-09-*` (8 sessions, each with lesson_learned + research_bridge + session_reasoning_graph)
- `D:\work\RaidUI\docs\style-guide\template-retro.md`
- `D:\work\RaidUI\docs\retros\session-retro-2026-04-22-shape-llm-arc.md`
- `D:\work\RaidUI\docs\retros\phase-1-retro.md` ... `phase-4.1-retro.md`
- `D:\work\start\precheck\docs\system-foundation-v2\adr\009-lesson-lifecycle-over-binary-toggle.md`
- `D:\work\planning\docs\adr\adr-007-qa-as-postmortem.md`
- `D:\work\planning\docs\session-retro-2026-04-15.md`
- `D:\work\planning-runtime\runs\run-20260415-*\qa-retro.md`
- `D:\work\start\planner\docs\ai-retrospective-findings.md`
- `D:\work\game\docs\retrospective-godot-cs-migration-2026-03-29.md`
- `D:\work\chatGPT_parser\tmp\research_session_2026-03-13-chatgpt-parser-contract-research\lesson_learned.md`
- `D:\work\archStandards\lessons-learned-03-17.md`
- `D:\work\start\contextforge\docs\retrospective-2026-03-21.md`, `retrospective-2026-03-23.md`
- `D:\work\start\precheck\docs\retrospective-2026-04-02-learning-subsystem.md`
- `D:\work\start\ashley\docs\retrospective-2026-04-04.md`
- `D:\work\www\retrospective-demo-launch.md`, `retrospective-ci-cd-and-restructure.md`

## Three modes of adoption

**Mode A — Literal schema replication.** `writing/` reproduces the session-artifact folder shape from this hub's `ARTIFACT_SCHEMA.md` almost exactly: `lesson_learned.md` filename, section structure (Summary / What Changed / Lessons Learned / Risks / Next Actions), and a partial set of contract files (lesson_learned, research_bridge, session_reasoning_graph) per session. No coordination — the protocol propagated through the chat-session prompt.

**Mode B — Structural maturation past the source.** RaidUI's `template-retro.md` is more sophisticated than anything this hub has produced. It declares: when to write a retro, filename conventions for phase vs. batch vs. stream retros, a section skeleton with concrete examples, explicit voice notes ("Specificity over politeness," "Attribute mechanisms, not people"), and what a retro is NOT (status file, changelog, performance review). It defines a promotion lifecycle: patterns that appear 2+ times move to `docs/style-guide/`. This hub does not have a comparable governance document.

**Mode C — Architectural decision-fication.** start/precheck and planning have made *load-bearing engineering decisions* about retrospective behavior:

- ADR-009 (precheck): lessons are state machines (`new → active → decaying → inactive`) with deterministic transition rules based on `recent_fail_rate`, not booleans. This treats retro output as live system state, not a static document.
- ADR-007 (planning): "QA is a post-mortem, never a gate." `result.success` is determined by pipeline completion, not by retro verdict. Verdicts (`Accept | Retry | Reject`) live in `review.json` as descriptive metadata; nothing automatic acts on them. Retros produce data, not decisions.

Both ADRs are operational restatements of this hub's `RESEARCH_CONTRACT.md` principle "Synthesis is exploratory, not deterministic" — expressed as code-level decisions in production systems.

## Cross-Session Insight

This hub's `RESEARCH_CONTRACT.md` says: "Research is artifact-first." The corpus on `D:\` now demonstrates that proposition empirically. When individual implementation systems (game, RaidUI, planning, precheck, writing, chatGPT_parser, ashley, contextforge, archStandards, www, planning-runtime) need a way to learn from completed work, they reach for the same artifact pattern this hub formalized — without being asked.

start/planner/ai-retrospective-findings.md goes further: it is essentially a *synthesis input* file (12 external sources, organized by theme: perception gap, "almost-right" problem, cognitive load, flow destruction, scaling trap, work intensification, handoff problem) — exactly the kind of document this hub's `synthesis/` directory was designed to consume.

The hub has been *outpaced by its own thesis*. The retrospective discipline is now load-bearing in 11+ systems, but the hub still has formal visibility only into liveView (registered) and chatGPT_parser (referenced via cross-repo session). The contract spread without governance, and the governance has not caught up.

## Comparison: source schema vs. emergent variants

| Dimension | This hub's schema | RaidUI template | precheck ADR-009 | planning ADR-007 |
|---|---|---|---|---|
| Scope | Single session | Phase or batch | Lesson over its lifetime | Single retrospective stage |
| Output | 5-file folder | Single doc with skeleton | Lesson with state | review.json + qa-retro.md + directive-suggestions.md |
| Authority | Tolerant ingest | Style-guide gate | Deterministic state machine | Never gating |
| Promotion path | None defined | "2+ uses → style-guide/" | "decaying" → "inactive" | "directive-suggestions.md" → next run inputs |
| Anti-pattern guidance | None | Explicit voice notes | Rejected: binary toggle, continuous score | Rejected: automatic retry |

Each variant added a dimension that this hub's source schema did not specify. The variants do not contradict the source — they extend it.

## Tensions / Counterpoints

- **Survivorship bias.** Repos without retros are invisible to a retro-glob. The "spread" may reflect what is glob-able more than what is genuinely shared practice.
- **Nominal vs. structural adoption.** A file named `retro.md` is not evidence that the artifact-first principle was internalized. The Game repo's retro uses traditional sections (What Happened / What Went Well / What Went Wrong) — an essay structure, not a contract.
- **The hub did not cause the spread.** Retrospectives have existed in software practice for decades. Attributing cross-repo presence to this hub's protocol is post-hoc.
- **Centralization may not be desirable.** If 11 systems each maintain their own retros productively, an index/hub may be a solution looking for a problem. The hub's value is in *synthesis across* — and synthesis only requires reading, not registering.
- **The variants might not be reabsorbable.** RaidUI's template assumes phase/track structure that does not generalize. precheck's lesson lifecycle assumes statistical signal (`recent_fail_rate`) the hub does not produce. Treating these as descendants for canonical absorption may force fit.

## Candidate Claims

- The artifact-first retrospective pattern propagates without centralized push when the artifact shape is small and the local value is legible.
- A research hub that defines a contract should expect implementation repos to evolve the contract beyond what the hub has codified — and should periodically reabsorb those evolutions as canonical when they generalize.
- The "registered systems" model in `SYSTEM_INDEX.md` may need to bifurcate into *contracted* (formal, two-way) and *observed* (one-way visibility) tiers.
- Implementation systems that make retrospective behavior an ADR-level decision (lifecycle states, non-gating) are a stronger signal of practice maturity than systems that merely emit retros.

## Open Questions

- Should this hub register the 11 observed systems formally, or remain a synthesis node that only references repos by reading them on demand?
- Does `RESEARCH_CONTRACT.md` need an artifact class for *operational/architectural decisions about retro behavior* (currently those would be ingested as observations, but they are structurally different)?
- Should the hub absorb RaidUI's `template-retro.md` as a canonical longer-form retro template, or keep its lighter `lesson_learned.md` schema and treat RaidUI's as a more-evolved descendant?
- Is "lesson lifecycle" (precheck ADR-009) generalizable to this hub's `research/observations/` corpus — i.e., should observations themselves have `new → active → decaying → inactive` states based on whether subsequent sessions reinforce or contradict them?
