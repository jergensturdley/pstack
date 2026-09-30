# FORK.md

This repo is the agent-neutral edition of pstack. Upstream pstack lives in
the `cursor/plugins` monorepo at `pstack/`. This fork extracts it into a
standalone repo so any agent that reads `SKILL.md` files can use it. Cursor
is not required.

A scheduled job syncs this fork from upstream every 3 days. It converts new
cursor-flavored content with the checklist in `CONVERT.md`, opens a pull
request here, and reports to the owner on Telegram.

## Files

- `README.md` is upstream's README, kept as-is. It documents the skills.
- `CONVERT.md` is the conversion checklist. It gates every sync.
- `.sync-keep` lists fork-only files the sync never overwrites or deletes.
- `scripts/sync-upstream.sh` mirrors `upstream/main`'s `pstack/` subtree into
  this repo root.

## Running a sync

```sh
scripts/sync-upstream.sh
# commit the raw sync, apply CONVERT.md, commit the conversion
```

The gate in `CONVERT.md` must pass before the conversion commit lands.

## Install from this fork

```sh
git clone https://github.com/jergensturdley/pstack.git
cp -r pstack/skills/* <your-agent-skills-dir>/
```

The scope table lives in upstream's `README.md`. Host specifics resolve
through `skills/shared/host-adapter.md`.
