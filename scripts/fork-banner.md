<!-- FORK-BANNER-START -->
# pstack, standalone and agent-neutral

This repository is a standalone republish of [pstack](https://github.com/cursor/plugins/tree/main/pstack),
the skills collection by **Lauren Tan ([@poteto](https://x.com/poteto))**.
All credit for the skills, the principles, and the idea is hers. This fork
exists only to carry her work to agents beyond Cursor: it is extracted from
the `cursor/plugins` monorepo into its own repo, and a scheduled job syncs it
from upstream every 3 days, converting cursor-specific instructions so any
agent that reads `SKILL.md` files can run it.

- Everything under `skills/`, `agents/`, `automations/`, and `docs/` is
  upstream pstack. The README below is upstream's, kept verbatim.
- Fork plumbing lives in `FORK.md` (what this repo is), `CONVERT.md`
  (the conversion checklist), and `scripts/sync-upstream.sh` (the sync).
- Install from this fork: `git clone https://github.com/jergensturdley/pstack.git`
  and copy `skills/*` into whichever directory your agent reads.

MIT licensed, same as upstream. See `LICENSE` and upstream `NOTICE`.

<!-- FORK-BANNER-END -->
