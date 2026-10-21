# Setting up a project

1. Create `projects/<slug>/` (short, neutral slug: `bank-doc-extraction`, not the client name).
2. Copy `project.local.example.yaml` to `project.local.yaml` and fill it in.
3. Copy `redact.example.txt` to `redact.txt` and list every sensitive term you can think of.
4. Put the material in `inputs/repo/`, `inputs/proposal/`, `inputs/annex/`. Clone the repo with full history if you can.
5. Run `/fde-analyze <slug>`, answer `work/questions.md` in `work/answers.md`, then run `/fde-write <slug>`.

Only `out/` is tracked by git.
