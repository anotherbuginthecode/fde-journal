# FDE Journal

A Claude Code pipeline that turns past client projects into short, anonymized case studies written from a Forward Deployed Engineer point of view.

Each project starts from three kinds of material: the proposal (what the customer was promised), the technical annex (how the team planned to build it) and the repository (what actually got built, and how it changed over time). The gap between plan and reality is where the interesting story usually is, so the pipeline is built around finding it.

## How it works

```
proposal + annex ──> docs-analyst ─┐
                                   ├─> delta-analyst ─> interviewer ─> questions.md
repo + git history ─> repo-analyst ┘                                        │
                                                                     (I answer)
                                                                            │
          out/case-study.md <── check-redactions <── anonymizer <── story-writer
```

| Agent | Job |
|---|---|
| `docs-analyst` | Extracts the plan: customer problem, goals, promised KPIs, planned architecture |
| `repo-analyst` | Describes what exists: infrastructure, architecture, core flow, AI parts, pivots in the git history, my own contribution |
| `delta-analyst` | Compares plan and reality, ranks the differences as story beats |
| `interviewer` | Asks me at most 12 questions about what the material can't say: why things changed, outcomes, my role, and confirms the reconstructed architecture |
| `story-writer` | Writes the case study: short prose plus architecture diagram, numbered flow, ownership areas and metrics, pseudonymizing as it goes |
| `anonymizer` | Independent re-identification check, PASS or FAIL |
| `portfolio-synthesizer` | Finds patterns across all case studies, drafts CV bullets and lists gaps |

Every claim carries a tag (`[verified]`, `[inferred]`, `[from-me]`) and a source. Only verified facts and my own answers reach the final text.

## Usage

```bash
# set up a project (see projects/_example/README.md)
/fde-analyze <slug>     # phase 1: analysis and interview questions
# answer projects/<slug>/work/answers.md
/fde-write <slug>       # phase 2: case study, anonymization, checks
/fde-portfolio          # cross-project overview
```

## Confidentiality

Client material stays on my machine. `.gitignore` tracks only `projects/*/out/` and the pipeline itself. A case study reaches `out/` only after two independent checks: the `anonymizer` agent (catches indirect identification, like a sector plus a distinctive detail) and `scripts/check-redactions.sh` (deterministic search for every sensitive term I listed). The analysis runs only where I'm allowed to process that material with an LLM.
