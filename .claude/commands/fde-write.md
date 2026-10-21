---
description: Phase 2. Write the anonymized case study for a project after the interview answers are in.
argument-hint: <project-slug>
---

Run phase 2 of the pipeline described in `CLAUDE.md` for `projects/$ARGUMENTS`.

1. Preflight: `work/answers.md` must exist and be non-empty. Stop otherwise.
2. Launch `story-writer`.
3. Launch `anonymizer` on `work/draft.md`. On FAIL, pass the findings to `story-writer` and repeat. After 2 failed loops, stop and show me the blocking findings.
4. On PASS, copy the draft to `out/case-study.md` and run `scripts/check-redactions.sh $ARGUMENTS`. If it fails, treat it as an anonymizer FAIL.
5. Reply with: word count, story beats used, claims dropped because they stayed `[inferred]`, and the anonymizer's minor findings.

Do not commit. I review `out/case-study.md` first.
