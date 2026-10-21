---
description: Phase 1. Analyze a project's proposal, annex and repo, then prepare interview questions.
argument-hint: <project-slug>
---

Run phase 1 of the pipeline described in `CLAUDE.md` for `projects/$ARGUMENTS`.

1. Preflight: check that `projects/$ARGUMENTS/project.local.yaml` and `redact.txt` exist. Stop if not.
2. Resolve sources as described in `CLAUDE.md` (phase 1, step 2): read `sources` in the YAML, clone remote repos into `inputs/repo/<name>/`, add anything in `inputs/`, write `work/sources.md`. Show me the resolved list and any source that wasn't found.
3. Launch `docs-analyst` and `repo-analyst` in parallel (skip the one with no input and say so).
4. Launch `delta-analyst`.
5. Launch `interviewer`.
6. Reply with: sources used, the top 3 story beats from `work/delta.md` (one line each), and the path to `work/questions.md`. Tell me to answer in `work/answers.md` and then run `/fde-write $ARGUMENTS`.

Do not write anything to `out/` in this phase.
