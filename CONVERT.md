# Cursor conversion checklist

Run `scripts/sync-upstream.sh` first. It stages the raw upstream sync. Then
apply this checklist and commit the result as the conversion commit. Upstream
pstack is written for Cursor; this fork runs on any agent. Keep the facts,
change only host wording. Do not rewrite whole sections.

Write fork-authored prose to the repo's own `skills/unslop/SKILL.md`. No em
dashes. Sentence case headings. Plain words over AI vocabulary.

## Prose

- "In a Cursor chat, run:" becomes "From your agent, run:" or plainer.
- "the Cursor environment" becomes "your agent's environment".

## Paths

| Upstream | This fork |
| --- | --- |
| `~/.cursor/rules/pstack-models.mdc` | `~/.pstack/models.md`, unless upstream already moved to it |
| `.cursor/automations/benny/` | `.agent/automations/benny/` |
| `.cursor/settings.json`, benny enable step | `.agent/settings.json`, or the host's project config |

Leave install-path tables alone when they already list several hosts
(`.agent/`, `.claude/`, `.cursor/`). They are host surveys, not instructions.

## Do not touch

- `endCursor` in `skills/poteto-mode/scripts/watch-pr/`. GraphQL pagination.
- `login: "cursor"` and `cursor_automation_id` in the same scripts. That is
  the Cursor bot on GitHub, not the host.
- `~/.cursor/projects/...` in `worktree-audit.sh` and `host-adapter.md`.
  Multi-host probe lists by design.

## Gate

Must pass before the conversion commit lands:

```sh
grep -rnE 'Cursor chat|\.cursor/rules|\.cursor/automations|\.cursor/settings' \
  --exclude-dir=node_modules --exclude-dir=.git .
```

Expected: zero hits. A hit means upstream brought cursor-specific content
this checklist does not cover. Convert it, or extend this file if the
pattern will recur. Never ignore it.

## plugin.json

Track upstream's copy. It is registry metadata, host-neutral enough. Do not
edit beyond what upstream ships.
