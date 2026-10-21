---
description: Build the cross-project overview from all finished case studies.
---

1. List `projects/*/out/case-study.md`. If fewer than two exist, stop and say so.
2. Launch `portfolio-synthesizer`.
3. Launch `anonymizer` on `portfolio/overview.md` (use the union of all projects' `redact.txt` files). On FAIL, fix and re-check once.
4. Run `scripts/check-redactions.sh --all`.
5. Reply with the positioning line, the patterns found and the gaps.

Do not commit. I review first.
