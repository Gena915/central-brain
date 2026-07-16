#!/usr/bin/env bash
# Central Brain installer (macOS / Linux)
# Publishes the skills to your agent and seeds your brain, resolving placeholders.
set -euo pipefail

# Note: named BRAIN_LANG (not LANG) on purpose. LANG is the shell locale variable, and
# overwriting it makes sed/grep/find emit "cannot change locale" warnings mid-install.
BRAIN="" NAME="" BRAIN_LANG="English" TARGET="claude"
while [ $# -gt 0 ]; do
  case "$1" in
    --brain)  BRAIN="$2"; shift 2 ;;
    --name)   NAME="$2"; shift 2 ;;
    --lang)   BRAIN_LANG="$2"; shift 2 ;;
    --target) TARGET="$2"; shift 2 ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

REPO="$(cd "$(dirname "$0")/.." && pwd)"
[ -n "$BRAIN" ] || { echo "ERROR: --brain <absolute path> is required" >&2; exit 1; }
[ -n "$NAME" ]  || NAME="You"

# --- helper: replace placeholders in a file, in place ---
render() { # $1 = file
  # escape sed replacement specials in values
  local b n l
  b=$(printf '%s' "$BRAIN" | sed -e 's/[\/&]/\\&/g')
  n=$(printf '%s' "$NAME"  | sed -e 's/[\/&]/\\&/g')
  l=$(printf '%s' "$BRAIN_LANG"  | sed -e 's/[\/&]/\\&/g')
  sed -i.bak -e "s/{{BRAIN}}/$b/g" -e "s/{{NAME}}/$n/g" -e "s/{{LANG}}/$l/g" "$1"
  rm -f "$1.bak"
}

# --- 1. seed the brain (only if fresh: don't clobber existing data) ---
if [ ! -f "$BRAIN/_index.md" ]; then
  echo "Seeding brain at: $BRAIN"
  mkdir -p "$BRAIN"
  cp -R "$REPO/brain/." "$BRAIN/"
  # render placeholders in every markdown file
  find "$BRAIN" -name '*.md' -type f | while read -r f; do render "$f"; done
else
  echo "Brain already seeded at $BRAIN - leaving it untouched."
fi

# --- 2. publish skills ---
skill_name() { grep -m1 '^name:' "$1" | sed 's/^name:[[:space:]]*//'; }

if [ "$TARGET" = "claude" ]; then
  DEST="$HOME/.claude/skills"
  mkdir -p "$DEST"
  echo "Installing skills to $DEST"
  for dir in "$REPO"/skills/*/; do
    src="$dir/SKILL.md"; [ -f "$src" ] || continue
    n=$(skill_name "$src"); [ -n "$n" ] || n=$(basename "$dir")
    mkdir -p "$DEST/$n"
    cp "$src" "$DEST/$n/SKILL.md"
    render "$DEST/$n/SKILL.md"
    echo "  + /$n"
  done
  echo "Done. Restart Claude Code so the skills load, then type /brain."
elif [ "$TARGET" = "codex" ]; then
  CMDS="$BRAIN/.commands"
  mkdir -p "$CMDS"
  echo "Writing portable commands to $CMDS"
  LIST=""
  for dir in "$REPO"/skills/*/; do
    src="$dir/SKILL.md"; [ -f "$src" ] || continue
    n=$(skill_name "$src"); [ -n "$n" ] || n=$(basename "$dir")
    desc=$(grep -m1 '^description:' "$src" | sed 's/^description:[[:space:]]*//' | cut -c1-120)
    cp "$src" "$CMDS/$n.md"
    render "$CMDS/$n.md"
    LIST="${LIST}- \`$n\` - ${desc}"$'\n'
    echo "  + $n"
  done
  # append a Commands section to the brain AGENTS.md (idempotent-ish)
  AG="$BRAIN/AGENTS.md"
  if ! grep -q '<!-- central-brain-commands -->' "$AG" 2>/dev/null; then
    {
      printf '\n<!-- central-brain-commands -->\n## Installed commands\n'
      printf 'When the owner invokes one of these (by name or trigger), load and follow the matching file in `.commands/`.\n\n'
      printf '%s' "$LIST"
    } >> "$AG"
  fi
  echo "Done. Open this brain with Codex; it reads AGENTS.md and the .commands/ prompts."
else
  echo "ERROR: --target must be 'claude' or 'codex'" >&2; exit 1
fi

# --- 3. write config so setup never runs again ---
mkdir -p "$REPO/.central-brain"
cat > "$REPO/.central-brain/config.json" <<EOF
{
  "name": "$NAME",
  "lang": "$BRAIN_LANG",
  "brain": "$BRAIN",
  "target": "$TARGET",
  "installed": true
}
EOF
echo "Wrote $REPO/.central-brain/config.json"
