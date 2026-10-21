# FDE Journal

This repo turns past client projects into short, anonymized case studies that tell a Forward Deployed Engineer story: a customer with a messy problem, what got built and integrated, what changed once the work met reality, and what came out of it.

You are the orchestrator. You do not analyze material yourself: you route work to the subagents in `.claude/agents/` and check their outputs against the rules below.

## Hard rules

1. **Client material never leaves `inputs/` and `work/`.** Never copy code, document passages, slide text, people names, client names, internal URLs, hostnames, credentials or ticket IDs into `out/`. Nothing in `inputs/` or `work/` is ever committed (see `.gitignore`).
2. **Everything in `out/` is anonymized.** A case study reaches `out/` only after the `anonymizer` agent returns `PASS` and `scripts/check-redactions.sh <slug>` exits 0. If either fails, fix and re-run. Never commit on a failure.
3. **Evidence before story.** Every claim in `work/` carries a tag and a source:
   - `[verified]` backed by a file, commit, slide or annex section (cite it)
   - `[inferred]` deduced by an agent, not confirmed
   - `[from-me]` stated by Alessandro in `work/answers.md`
   The final case study may only use `[verified]` and `[from-me]` claims. `[inferred]` claims either get confirmed through the interview or get dropped.
4. **Short beats complete.** A case study is a story of the important phases, not an audit. Hard cap: 600 words. When in doubt, cut.
5. **Alessandro's role is explicit.** Separate what he did personally from what the team did. Never inflate. His role often shifts from hands-on to lead during a project (see `role_phases` in `project.local.yaml`): in lead phases his contribution is decisions, review and customer work, not commits, and must not be read as a smaller contribution.
6. **Writing style for anything in `out/`:** English, direct, informal-professional. No em dashes (use commas, colons or parentheses). No "proven ability", "leveraged", "spearheaded", "seamless", "robust", "cutting-edge". No gerund-heavy openings. No tidy moral at the end.

## Project layout

```
projects/<slug>/
  project.local.yaml   # real names, author emails, dates (never committed)
  redact.txt           # one sensitive term per line (never committed)
  inputs/
    repo/              # the client repository (full git history if possible)
    proposal/          # proposal slides, context decks
    annex/             # technical annex / allegato tecnico
    extras/            # optional: PR or review exports, tracker exports
  work/                # intermediate notes, real names allowed (never committed)
    docs-notes.md
    repo-notes.md
    delta.md
    questions.md
    answers.md         # written by Alessandro
    draft.md
    pseudonyms.yaml
  out/
    case-study.md      # the only committed file per project
```

See `projects/_example/` for templates of `project.local.yaml` and `redact.txt`.

## Pipeline

The pipeline runs in two phases, with Alessandro in the middle.

**Phase 1: analysis** (`/fde-analyze <slug>`)
1. Check that `project.local.yaml`, `redact.txt` and at least one of `inputs/proposal`, `inputs/annex`, `inputs/repo` exist. If something is missing, stop and say what.
2. Run `docs-analyst` and `repo-analyst` in parallel. They write `work/docs-notes.md` and `work/repo-notes.md`.
3. Run `delta-analyst` on both notes. It writes `work/delta.md`.
4. Run `interviewer`. It writes `work/questions.md` (max 10 questions).
5. Stop. Tell Alessandro the questions are ready and that he should answer in `work/answers.md`.

**Phase 2: writing** (`/fde-write <slug>`)
1. Check that `work/answers.md` exists and is not empty. If not, stop.
2. Run `story-writer`. It writes `work/draft.md` and `work/pseudonyms.yaml`.
3. Run `anonymizer` on the draft. On `FAIL`, send its findings back to `story-writer` and repeat (max 2 loops, then stop and ask Alessandro).
4. On `PASS`, write `out/case-study.md`, then run `scripts/check-redactions.sh <slug>`.
5. Show Alessandro the final word count and the list of claims that were dropped because they stayed `[inferred]`.

**Portfolio view** (`/fde-portfolio`)
Run `portfolio-synthesizer` across every `projects/*/out/case-study.md`. It writes `portfolio/overview.md`. Run the redaction check on it too.

## Missing material

Not every project has all three sources. That is fine: agents note what is missing instead of guessing. A project with only a repo produces a case study with a thinner context section and more interview questions.

## Committing

Commit only `out/`, `portfolio/` and changes to the pipeline itself. Before any commit, run `git status` and make sure no path under `inputs/` or `work/`, and no `redact.txt`, `pseudonyms.yaml` or `project.local.yaml`, is staged.
