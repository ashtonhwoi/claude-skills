-- deletes OPEN reminders whose due time has passed and were fixed-time events (title starts with a clock "🕐")
on run
  tell application "Reminders"
    if exists list "Today" then delete (reminders of list "Today" whose completed is false and name starts with "🕐")
  end tell
end run
