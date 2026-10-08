---
name: daily-reminders
description: Refresh an Apple Reminders "Today" list every morning from your calendar, deadlines and last night's leftovers, and keep a journal of what you ticked off. macOS only. Use when the user wants an automatic daily to-do list, a morning list refresh, or a Reminders list that rolls over unfinished tasks.
---

# daily-reminders

A small headless job: each morning Claude Code reads your calendar and notes, clears yesterday's
ticked items into a journal, and rebuilds one Reminders list called **Today**. Unfinished tasks
roll over, calendar events become `🕐` items with times, and a cap keeps the list short.

## What is in the folder
- `scripts/` — four AppleScripts that dump, add and clear Reminders, `cal-today.js` (reads macOS
  Calendar through EventKit), and `run-refresh.sh` (runs `claude -p` with a locked-down tool list).
- `templates/daily-prompt.txt` — the instruction the job runs. Edit the bracketed parts: your
  deadlines file, standing daily items and notes to read.
- `templates/launchd.plist.template` — schedules it.

## Set up
1. Copy the folder to `~/.claude/skills/daily-reminders/` and edit `templates/daily-prompt.txt`.
2. Run `osascript scripts/rem-add.applescript "test" "" "" 5` once and allow the Reminders
   permission, then delete the test item. Run `osascript -l JavaScript scripts/cal-today.js`
   once and allow the Calendar permission.
3. Dry run: `scripts/run-refresh.sh`, then check the list and `~/.claude/skills/daily-reminders/logs/`.
4. Schedule: copy the plist template to `~/Library/LaunchAgents/`, replace `YOURNAME`, and run
   `launchctl load ~/Library/LaunchAgents/<file>.plist`.

## Rules the job follows
- It may only touch the `Today` list and append to one journal file. It never edits calendar
  events, sends messages or changes other files — the `--allowedTools` list in `run-refresh.sh`
  enforces this, so keep it narrow.
- Appends only; it never rewrites history.
- Unknown dates stay `TBC`; it never invents one.

## Limits
macOS only. The Mac must be awake (or wake via launchd) at the scheduled time. Headless runs use
your own Claude Code login, so they count against your usage.
