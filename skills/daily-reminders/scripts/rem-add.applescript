-- usage: osascript rem-add.applescript "<title>" "<HH:MM or empty>" "<notes>" "<priority 0|1|5|9>"
on run argv
  set t to item 1 of argv
  set tm to item 2 of argv
  set n to item 3 of argv
  set p to (item 4 of argv) as integer
  tell application "Reminders"
    if not (exists list "Today") then make new list with properties {name:"Today"}
    set L to list "Today"
    set r to make new reminder at end of L with properties {name:t, body:n, priority:p}
    if tm is not "" then
      set d to current date
      set hours of d to (text 1 thru 2 of tm) as integer
      set minutes of d to (text 4 thru 5 of tm) as integer
      set seconds of d to 0
      set due date of r to d
      set remind me date of r to d
    end if
  end tell
end run
