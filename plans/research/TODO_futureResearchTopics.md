# TODO_futureResearchTopics

This document captures speculative research directions enabled by the current chatgpt_parser artifact graph.

These are NOT implementation tasks.
They are questions and experiments that could produce useful insights once the pipeline stabilizes.

Current dataset baseline:

conversations: 380
messages: 19045
graph nodes: 28603
graph edges: 97574
projection files: 13

The goal of these research topics is to explore what kinds of insight a conversation + artifact graph might produce.

---

Research Area 1 — Conversation Complexity

Question:
Which conversations are structurally complex?

Possible signals:
- message count
- branching depth
- artifact production
- entity diversity

Potential insight:
Identify conversations that correspond to real problem-solving vs simple Q&A.

---

Research Area 2 — Artifact Productivity

Question:
Which conversations generate artifacts?

Signals:
Conversation ? PRODUCED ? Artifact

Possible insight:
Identify sessions where ideas actually turned into output.

---

Research Area 3 — Command Usage Patterns

Question:
Which commands appear most often and in what context?

Signals:
Command ? EMITTED_IN ? Message

Possible insight:
Identify common workflow patterns.

---

Research Area 4 — Topic Recurrence

Question:
Which topics appear across multiple conversations?

Signals:
Topic ? TAGGED_WITH ? Message

Possible insight:
Reveal recurring areas of interest.

---

Research Area 5 — Entity Clusters

Question:
Which entities frequently appear together?

Signals:
Entity ? MENTIONS ? Message

Possible insight:
Discover clusters of related concepts.

---

Research Area 6 — Timeline Activity

Question:
When do conversations occur most frequently?

Signals:
Timeline projection.

Possible insight:
Work rhythm and burst activity periods.

---

Research Area 7 — Artifact Lineage

Question:
How do artifacts relate to conversations and commands?

Signals:
Command ? PRODUCED ? Artifact
Artifact ? EMITTED_IN ? Message

Possible insight:
Map how outputs are created.

---

Two Near-Term Research Steps

Step 1 — Graph Exploration Queries

Build a small set of repeatable queries:

- most artifact-producing conversations
- most common commands
- most frequently mentioned entities

Output format:
analysis markdown reports.

This provides the first practical insights from the dataset.

---

Step 2 — Cross-Session Topic Map

Construct a simple graph projection:

Topic ? Conversations referencing topic

Metrics:
- number of conversations per topic
- time span of topic usage

Possible insight:
Identify long-running interest areas.

---

Notes

These ideas are intentionally lightweight.

They should only be pursued after pipeline stabilization tasks are complete, particularly:

- image pointer resolution
- graph warning triage
- projection validation
- snapshot manifest automation

The purpose of this document is simply to capture possible directions so they are not lost.
