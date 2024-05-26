import Foundation

extension Date.FormatStyle {
  /// Appends the weekday to this formatter only when the year of the event is the current year.
  /// Events that take place during the present year do not show the year and instead show the weekday.
  mutating func appendWeekday(eventDate: Date, now: Date) {
    if calendar.component(.year, from: eventDate) == calendar.component(.year, from: now) {
      self = self.weekday(.wide)
    }
  }

  /// Appends the year to this formatter only if the event takes place in a future year.
  mutating func appendYear(eventDate: Date, now: Date) {
    let eventYear = calendar.component(.year, from: eventDate)
    let thisYear = calendar.component(.year, from: now)

    if eventYear != thisYear {
      self = self.year()
    }
  }

  /// Appends the minute to this formatter only if either the start or the end date are different to zero.
  /// Otherwise, if the time in on the hour (:00) the minute will be missing from the date: "10 AM".
  ///
  /// On 24 hour cycle configurations the minute is always added as there is no other time indicator.
  mutating func appendMinute(startDate: Date) {
    // For 24h cycles, always add the minute because there is no other time indicator
    guard let uses24Hour = locale.uses24HourClock, uses24Hour == false else {
      self = self.minute()
      return
    }

    // The minute is dropped if the hour in on the clock (:00).
    if startDate.isOClock(calendar: calendar) == false {
      self = self.minute()
    }
  }

  /// Appends the time zone only if the user's and the event's time zones are different.
  mutating func appendTimeZone(eventTimeZone: TimeZone, currentTimeZone: TimeZone) {
    if eventTimeZone != currentTimeZone {
      self = self.timeZone(.genericName(.short))
    }
  }

  /// Sets the time zone used to localize the date.
  mutating func setTimeZone(eventTimeZone: TimeZone, currentTimeZone: TimeZone) {
    self.timeZone = eventTimeZone
    self.calendar.timeZone = eventTimeZone
  }
}

extension Date.IntervalFormatStyle {
  /// Appends the weekday (abbreviated) to this formatter only when the year of the event is the current year.
  /// Events that take place during the present year do not show the year and instead show the weekday.
  ///
  /// The weekday is abbreviated when the formatter needs to show two different days.
  mutating func appendWeekday(
    startDate: Date,
    endDate: Date,
    now: Date
  ) {
    if calendar.component(.year, from: startDate) == calendar.component(.year, from: now) {
      if startDate.isSameDate(anotherDate: endDate, calendar: calendar) {
        self = self.weekday(.wide)
      } else {
        self = self.weekday(.abbreviated)
      }
    }
  }

  /// Appends the month to this formatter.
  /// It uses an abbreviated version if start and end months are different for space purposes.
  mutating func appendMonth(startDate: Date, endDate: Date) {
    if startDate.isSameDate(anotherDate: endDate, calendar: calendar) {
      self = self.month(.wide)
    } else {
      self = self.month(.abbreviated)
    }
  }

  /// Appends the year to this formatter only if the event takes place in a future year.
  mutating func appendYear(eventDate: Date, now: Date) {
    let eventYear = calendar.component(.year, from: eventDate)
    let thisYear = calendar.component(.year, from: now)

    if eventYear > thisYear {
      self = self.year()
    }
  }

  /// Appends the minute to this formatter only if either the start or the end date are different to zero.
  /// Otherwise, if the time in on the hour (:00) the minute will be missing from the date: "10 AM".
  ///
  /// On 24 hour cycle configurations the minute is always added as there is no other time indicator.
  mutating func appendMinute(startDate: Date, endDate: Date) {
    // For 24h cycles, always add the minute because there is no other time indicator
    guard let uses24Hour = locale.uses24HourClock, uses24Hour == false else {
      self = self.minute()
      return
    }

    // The minute is dropped if the hour in on the clock (:00).
    if startDate.isOClock(calendar: calendar) == false || endDate.isOClock(calendar: calendar) == false {
      self = self.minute()
    }
  }

  /// Appends the time zone only if the user's and the event's time zones are different.
  mutating func appendTimeZone(eventTimeZone: TimeZone, currentTimeZone: TimeZone) {
    if eventTimeZone != currentTimeZone {
      self = self.timeZone(.genericName(.short))
    }
  }

  /// Sets the time zone used to localize the date.
  mutating func setTimeZone(eventTimeZone: TimeZone, currentTimeZone: TimeZone) {
    self.timeZone = eventTimeZone
    self.calendar.timeZone = eventTimeZone
  }
}
