#!/usr/bin/env bash
# Sync this repo from upstream (cursor/plugins, pstack/ subtree).
#
# Mechanical half of the sync. The semantic half lives in CONVERT.md and is
# applied by the agent after this script stages the raw sync.
#
# Crash safety: upstream content is extracted with git archive into a temp
# dir, then rsynced over the repo. The repo is never deleted first, so a
# failed run leaves the old tree intact and a re-run completes the mirror.
# Fork-only files in .sync-keep survive every sync.
set -euo pipefail

REPO="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

cd "$REPO"
git fetch upstream main --quiet

up_tip=$(git rev-parse --short upstream/main)
last=$(git log -1 --format='%h %cs' --grep='sync(pstack)' 2>/dev/null)
echo "upstream tip: $up_tip ($(git log -1 --format=%cs upstream/main))"
echo "last sync:    ${last:-never}"

mkdir "$TMP/src"
git archive upstream/main:pstack | tar -x -C "$TMP/src"

rsync -a --delete --exclude-from=.sync-keep "$TMP/src/" "$REPO/"

# Re-apply the fork banner to README.md. The sync overwrites README with
# upstream's copy; the banner goes back on top. Idempotent via the end marker.
python3 - <<'PY'
banner = open('scripts/fork-banner.md').read()
readme = open('README.md').read()
marker = '<!-- FORK-BANNER-END -->'
if marker in readme:
    readme = readme.split(marker, 1)[1].lstrip('\n')
open('README.md', 'w').write(banner + readme)
PY

[ -d "$REPO/.git" ] || { echo "FATAL: .git missing after rsync; keep-list is broken" >&2; exit 1; }

git add -A
if git diff --cached --quiet; then
  echo "NO-CHANGES: already at upstream $up_tip"
  exit 2
fi

echo "--- staged:"
git diff --cached --stat | tail -4
echo "OK: raw sync staged. Apply CONVERT.md next, then commit."
