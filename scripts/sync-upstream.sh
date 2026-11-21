#!/usr/bin/env bash
# Force-sync rule files from upstream (LingJingMaster/Shadowrocket-Rules).
#
# Every file tracked by upstream is replaced with the upstream version,
# except fork-owned (protected) paths. Files deleted upstream are removed
# too, unless they are protected or generated from a custom/ overlay.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

UPSTREAM_REF="${1:-upstream/main}"

# Paths that belong to this fork; never touched by the upstream sync.
is_protected() {
  case "$1" in
    .github|.github/*) return 0 ;;
    custom|custom/*)    return 0 ;;
    scripts|scripts/*)  return 0 ;;
    README.md)          return 0 ;;
    *)                  return 1 ;;
  esac
}

upstream_has() {
  git cat-file -e "$UPSTREAM_REF:$1" 2>/dev/null
}

# 1) Remove files that no longer exist upstream
while IFS= read -r f; do
  if is_protected "$f"; then continue; fi
  if upstream_has "$f"; then continue; fi
  # keep root files that are generated from a custom/ overlay
  if [ -f "custom/$f" ]; then continue; fi
  git rm -q -f --ignore-unmatch "$f"
done < <(git ls-files)

# 2) Overwrite files with the upstream version
while IFS= read -r f; do
  if is_protected "$f"; then continue; fi
  git checkout "$UPSTREAM_REF" -- "$f"
done < <(git ls-tree -r --name-only "$UPSTREAM_REF")

echo "Synced $(git ls-tree -r --name-only "$UPSTREAM_REF" | wc -l | tr -d ' ') files from $UPSTREAM_REF ($(git rev-parse "$UPSTREAM_REF"))"
