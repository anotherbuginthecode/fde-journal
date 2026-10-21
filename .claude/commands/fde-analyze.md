---
description: Phase 1. Analyze a project's proposal, annex and repo, then prepare interview questions.
argument-hint: <project-slug>
---

Run phase 1 of the pipeline described in `CLAUDE.md` for `projects/$ARGUMENTS`.

1. Preflight: check that `projects/$ARGUMENTS/project.local.yaml` and `redact.txt` exist and that at least one of `inputs/proposal`, `inputs/annex`, `inputs/repo` is non-empty. Report which sources are present. Stop if the preflight fails.
2. Launch `docs-analyst` and `repo-analyst` in parallel (skip the one with no input and say so).
3. Launch `delta-analyst`.
4. Launch `interviewer`.
5. Reply with: sources used, the top 3 story beats from `work/delta.md` (one line each), and the path to `work/questions.md`. Tell me to answer in `work/answers.md` and then run `/fde-write $ARGUMENTS`.

Do not write anything to `out/` in this phase.
