# Setting up a project

1. Create `projects/<slug>/` (short, neutral slug: `bank-doc-extraction`, not the client name).
2. Copy `project.local.example.yaml` to `project.local.yaml` and fill it in.
3. Copy `redact.example.txt` to `redact.txt` and list every sensitive term you can think of.
4. List where the material lives under `sources` in `project.local.yaml`: local repo paths, git URLs (cloned automatically with full history), proposal and annex files. If you'd rather copy files by hand, put them in `inputs/proposal/`, `inputs/annex/`, `inputs/extras/` instead: both ways work.
   If you led the team for part of the project, export the PRs you reviewed or merged into `inputs/extras/` (for GitHub: `gh pr list --state merged --search "reviewed-by:<you>" --limit 500 --json number,title,mergedAt,author > inputs/extras/reviewed-prs.json`). Titles only, no comment text needed.
5. Run `/fde-analyze <slug>`, answer `work/questions.md` in `work/answers.md`, then run `/fde-write <slug>`.

Only `out/` is tracked by git.
