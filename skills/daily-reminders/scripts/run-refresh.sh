#!/bin/zsh
# Daily refresh of the Reminders "Today" list: runs Claude Code headless with the prompt in
# ../templates/daily-prompt.txt. Point PROMPT at your edited copy, then schedule it (see SKILL.md).
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
cd "$HOME"
DIR="$HOME/.claude/skills/daily-reminders"
PROMPT="$DIR/templates/daily-prompt.txt"
JOURNAL="$HOME/today-journal.md"          # the file the prompt appends yesterday's ticked items to
mkdir -p "$DIR/logs"
LOG="$DIR/logs/$(date +%Y-%m-%d).log"
claude -p "$(cat "$PROMPT")" \
  --allowedTools "Read" "Grep" "Glob" "ToolSearch" \
    "Bash(osascript:*)" "Bash(tail:*)" "Bash(cat:*)" "Bash(date:*)" \
    "Edit($JOURNAL)" \
  >> "$LOG" 2>&1
echo "exit $? at $(date)" >> "$LOG"
