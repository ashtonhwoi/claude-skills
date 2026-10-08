-- prints one line per reminder in "Today": done|<title>  or  open|<title>
on run
  set out to ""
  tell application "Reminders"
    if not (exists list "Today") then return ""
    repeat with r in reminders of list "Today"
      if completed of r then
        set out to out & "done|" & name of r & linefeed
      else
        set out to out & "open|" & name of r & linefeed
      end if
    end repeat
  end tell
  return out
end run
