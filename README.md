# claude-skills

Agent skills I wrote and use daily in [Claude Code](https://claude.com/claude-code).

A *skill* is a folder with a `SKILL.md` that teaches an agent a workflow — when to
start it, what to do at each step, and where it is allowed to stop. These are the ones
that survived real use, not the ones that were fun to write.

## The skills

| Skill | What it does |
|---|---|
| [`lfg`](skills/lfg) | Turns a half-formed thought into a production-grade prompt, waits for a one-word approval, then runs it. Solves the problem where you know what you want but not how to ask for it. |
| [`tech-company-analyst`](skills/tech-company-analyst) | Fans out one research subagent per company in parallel, then synthesises a single analyst briefing — reactions, competitive read, 6–24 month outlook, and an "Explain Like I'm 15" ending. |

## Install

Skills live in `~/.claude/skills/`. Drop one in and it is available immediately.

```bash
git clone https://github.com/ashtonhwoi/claude-skills.git
cp -R claude-skills/skills/lfg ~/.claude/skills/
cp -R claude-skills/skills/tech-company-analyst ~/.claude/skills/
```

Then invoke with `/lfg` or by describing the task — each skill's `description`
frontmatter is what the agent matches against, so it triggers on intent, not only on
the slash command.

## What I learned writing these

**The description field is the whole product.** A skill that never triggers is a skill
that does not exist. Most of the editing time goes into the one-paragraph
`description`, not the instructions underneath it.

**Name the stopping point.** Agents are enthusiastic. `lfg` works because it has an
explicit approval gate that it is told never to skip; without one it would draft a
prompt and immediately run something the user did not want.

**Parallelism beats depth for research.** `tech-company-analyst` is one subagent per
company rather than one agent doing all of them in sequence — same token budget, much
fresher sourcing, and no company gets the tired end of the context window.

## Also in my setup, by other people

- [`watch`](https://github.com/bradautomates/claude-video) by **bradautomates** (MIT) —
  gives the agent a video input: yt-dlp download, ffmpeg frame extraction, caption or
  Whisper transcript. Not vendored here; install it from the upstream repo. It is the
  backbone of most of my video work.

## Licence

MIT — see [LICENSE](LICENSE). Take them, fork them, change the parts that do not fit
how you work.
