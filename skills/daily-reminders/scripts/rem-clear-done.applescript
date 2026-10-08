-- deletes completed reminders from "Today" (run AFTER they are logged)
on run
  tell application "Reminders"
    if exists list "Today" then delete (reminders of list "Today" whose completed is true)
  end tell
end run
