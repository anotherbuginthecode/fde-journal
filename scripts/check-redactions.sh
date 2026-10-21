#!/usr/bin/env bash
# Deterministic last line of defense: fails if any term from redact.txt
# (or the left side of pseudonyms.yaml) appears in a committed output.
# Usage: scripts/check-redactions.sh <slug> | --all
set -euo pipefail
cd "$(dirname "$0")/.."

collect_terms() {
  local dir="$1"
  [[ -f "$dir/redact.txt" ]] && grep -vE '^\s*(#|$)' "$dir/redact.txt" || true
  [[ -f "$dir/work/pseudonyms.yaml" ]] && \
    sed -nE 's/^\s*"?([^":#]+)"?\s*:.*/\1/p' "$dir/work/pseudonyms.yaml" || true
}

if [[ "${1:-}" == "--all" ]]; then
  dirs=(projects/*/)
  targets=(projects/*/out/*.md portfolio/*.md)
elif [[ -n "${1:-}" ]]; then
  dirs=("projects/$1/")
  targets=("projects/$1/out/"*.md)
else
  echo "usage: $0 <slug> | --all" >&2; exit 2
fi

terms_file="$(mktemp)"; trap 'rm -f "$terms_file"' EXIT
for d in "${dirs[@]}"; do collect_terms "${d%/}"; done \
  | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | awk 'length > 1' | sort -u > "$terms_file"

existing=()
for t in "${targets[@]}"; do [[ -f "$t" ]] && existing+=("$t"); done
if [[ ${#existing[@]} -eq 0 ]]; then echo "no output files to check"; exit 0; fi
if [[ ! -s "$terms_file" ]]; then
  echo "WARNING: no redaction terms found, nothing to check against" >&2; exit 1
fi

fail=0
if grep -inF -f "$terms_file" "${existing[@]}"; then
  echo "FAIL: sensitive terms found above" >&2; fail=1
fi
if grep -n $'—' "${existing[@]}"; then
  echo "FAIL: em dash found above" >&2; fail=1
fi
[[ $fail -eq 0 ]] && echo "PASS: ${#existing[@]} file(s) clean against $(wc -l < "$terms_file") terms"
exit $fail
