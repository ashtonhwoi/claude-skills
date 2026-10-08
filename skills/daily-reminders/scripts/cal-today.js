// Prints today's events from every calendar synced into macOS Calendar (recurring events expanded).
// usage: osascript -l JavaScript cal-today.js [daysAhead]
// Edit SKIP to hide calendars you never want in your list (birthdays, holidays, ...).
const SKIP = ["Birthdays", "Siri Suggestions"];
ObjC.import('EventKit');
ObjC.import('Foundation');
function run(argv) {
  const ahead = argv.length ? parseInt(argv[0]) : 0;
  const store = $.EKEventStore.alloc.init;
  let done = false, granted = false;
  store.requestFullAccessToEventsWithCompletion((g, e) => { granted = g; done = true; });
  const until = $.NSDate.dateWithTimeIntervalSinceNow(10);
  while (!done && until.timeIntervalSinceNow > 0) $.NSRunLoop.currentRunLoop.runUntilDate($.NSDate.dateWithTimeIntervalSinceNow(0.1));
  if (!granted) return "NO_CALENDAR_ACCESS";
  const cal = $.NSCalendar.currentCalendar;
  const start = cal.startOfDayForDate($.NSDate.date);
  const end = start.dateByAddingTimeInterval(86400 * (ahead + 1));
  const pred = store.predicateForEventsWithStartDateEndDateCalendars(start, end, $());
  const evs = store.eventsMatchingPredicate(pred);
  const fmt = $.NSDateFormatter.alloc.init; fmt.dateFormat = "EEE dd MMM HH:mm";
  const out = [];
  for (let i = 0; i < evs.count; i++) {
    const e = evs.objectAtIndex(i);
    const c = e.calendar.title.js;
    if (SKIP.includes(c)) continue;
    out.push(fmt.stringFromDate(e.startDate).js + "–" + fmt.stringFromDate(e.endDate).js.slice(-5) +
      (e.allDay ? " [all-day]" : "") + " | " + e.title.js + " | " + c +
      (e.location && e.location.js ? " | @" + e.location.js : ""));
  }
  return out.sort().join("\n") || "NO_EVENTS";
}
