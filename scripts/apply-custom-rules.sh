#!/usr/bin/env bash
# Apply the custom rules stored in custom/ on top of the upstream rule files.
#
#   custom/<Name>.list              -> appended to <Name>.list in the repo root
#                                       (the target file is created if missing)
#   custom/Shadowrocket.conf.rules  -> inserted at the TOP of the [Rule] section
#                                       of Shadowrocket.conf, so custom rules
#                                       take priority over upstream rules
#
# Additionally, all raw.githubusercontent.com URLs of the upstream repo inside
# Shadowrocket.conf are rewritten to this fork, so Shadowrocket loads the rule
# sets (including your custom entries) from THIS repo instead of upstream.
#
# The script is idempotent: running it twice will not duplicate rules.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

UPSTREAM_REPO="LingJingMaster/Shadowrocket-Rules"
FORK_REPO="codewings/My-Shadowrocket-Rules"

CONF="Shadowrocket.conf"
RULES_OVERLAY="custom/Shadowrocket.conf.rules"
BEGIN_MARKER="# ===== BEGIN custom rules (managed by scripts/apply-custom-rules.sh, do not edit) ====="
END_MARKER="# ===== END custom rules ====="

has_content() { # at least one non-empty, non-comment line
  grep -qvE '^[[:space:]]*(#|$)' "$1"
}

strip_block() { # remove a previously inserted marker block (and its surrounding blank lines) from $1
  awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" '
    function flush() { if (have_pending) print pending; have_pending = 0 }
    {
      if (skip) {
        if ($0 == end) { skip = 0; skip_next_blank = 1 }
        next
      }
      if ($0 == begin) {
        if (have_pending && pending ~ /^[[:space:]]*$/) have_pending = 0 # drop blank line before the block
        flush()
        skip = 1
        next
      }
      if (skip_next_blank) {
        skip_next_blank = 0
        if ($0 ~ /^[[:space:]]*$/) next # drop blank line after the block
      }
      flush()
      pending = $0
      have_pending = 1
    }
    END { flush() }
  ' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
}

# --- 1) .list overlays ------------------------------------------------------
shopt -s nullglob
for overlay in custom/*.list; do
  target="$(basename "$overlay")"
  if [ -f "$target" ]; then
    strip_block "$target"
  fi
  if ! has_content "$overlay"; then
    continue # nothing effective to add
  fi
  {
    echo ""
    echo "$BEGIN_MARKER"
    cat "$overlay"
    echo "$END_MARKER"
  } >> "$target"
done

# --- 2) [Rule] overlay for Shadowrocket.conf --------------------------------
if [ -f "$CONF" ]; then
  strip_block "$CONF"
  if [ -f "$RULES_OVERLAY" ] && has_content "$RULES_OVERLAY"; then
    awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" -v overlay="$RULES_OVERLAY" '
      BEGIN {
        while ((getline line < overlay) > 0)
          block = block line "\n"
      }
      /^\[Rule\][[:space:]]*$/ && !done {
        print
        print ""
        print begin
        printf "%s", block
        print end
        print ""
        done = 1
        next
      }
      { print }
    ' "$CONF" > "$CONF.tmp" && mv "$CONF.tmp" "$CONF"
    if ! grep -qF "$BEGIN_MARKER" "$CONF"; then
      echo "WARNING: no [Rule] section found in $CONF; custom rules were NOT inserted." >&2
    fi
  fi
fi

# --- 3) Point rule-set / update URLs at this fork ---------------------------
sed -i.bak \
  "s|https://raw\.githubusercontent\.com/${UPSTREAM_REPO}/|https://raw.githubusercontent.com/${FORK_REPO}/|g" \
  "$CONF" && rm -f "$CONF.bak"

echo "Custom rules applied."
