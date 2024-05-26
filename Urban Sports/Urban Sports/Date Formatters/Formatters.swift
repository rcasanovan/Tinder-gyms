import Foundation

extension EventDate {
  /// A displayable formatted date string using the event's data and the user's settings.
  ///
  /// The end date time zone is ignored because date formatters don't deal with multiple time zones. These are rare
  /// use cases and even using one single time zone is more human-readable.
  ///
  /// Online events use the user's time zone; otherwise the event's time zone is used to compute the date,
  /// except if it coincides with the user's.
  ///
  /// Year is omitted unless the event takes place in another year.
  ///
  /// Usage for a date only date (no range):
  /// ```
  /// let string = EventDate(date: .now, timeZone: .current)?
  ///   .dateOnly(
  ///     end: nil,
  ///     userPreference: .init(locale: .current, timeZone: .current),
  ///     now: .now
  ///   )
  /// 'Thursday, December 21'
  /// ```
  ///
  /// - Parameters:
  ///   - end: event end date (date and time zone).
  ///   - userPreference: the user's current preferences (locale and time zone).
  ///   - now: current date set on device.
  /// - Returns: a displayable string with the weekday, day, month and year.
  ///     If no start date is provided it returns nil.
  public func dateOnly(
    end: EventDate?,
    userPreference: UserPreference,
    now: Date
  ) -> String {
    // Range
    if let end {
      var formatter = Date.IntervalFormatStyle().day()

      formatter.setTimeZone(eventTimeZone: self.timeZone, currentTimeZone: userPreference.timeZone)
      formatter.locale = userPreference.locale

      formatter.appendWeekday(
        startDate: self.date,
        endDate: end.date,
        now: now
      )
      formatter.appendMonth(
        startDate: self.date,
        endDate: end.date
      )
      formatter.appendYear(eventDate: self.date, now: now)

      return (self.date..<end.date).formatted(formatter)
    }

    // Start value only
    var formatter = Date.FormatStyle.dateTime.month(.wide).day()

    formatter.setTimeZone(eventTimeZone: self.timeZone, currentTimeZone: userPreference.timeZone)
    formatter.locale = userPreference.locale
    formatter.capitalizationContext = .beginningOfSentence

    formatter.appendWeekday(eventDate: self.date, now: now)
    formatter.appendYear(eventDate: self.date, now: now)

    return self.date.formatted(formatter)
  }

  /// A displayable formatted date string using the event's data and the user's settings.
  ///
  /// The end date time zone is ignored because date formatters don't deal with multiple time zones. These are rare
  /// use cases and even using one single time zone is more human-readable.
  ///
  /// Online events use the user's time zone; otherwise the event's time zone is used to compute the date,
  /// except if it coincides with the user's.
  ///
  /// Usage for a time only date (no range):
  /// ```
  /// let string = EventDate(date: .now, timeZone: .current)?
  ///   .timeOnly(
  ///     end: nil,
  ///     isOnline: false,
  ///     userPreference: .init(locale: .current, timeZone: .current)
  ///   )
  /// '10 AM GMT'
  /// ```
  ///
  /// - Parameters:
  ///   - end: event end date (date and time zone).
  ///   - isOnline: a boolean value indicating if the event is online.
  ///   - userPreference: the user's current preferences (locale and time zone).
  /// - Returns: a displayable string with the hour, minute and time zone (if needed).
  ///     If no start date is provided it returns nil.
  public func timeOnly(
    end: EventDate?,
    userPreference: UserPreference
  ) -> String {
    // Range
    if let end {
      var formatter = Date.IntervalFormatStyle().hour()

      formatter.setTimeZone(eventTimeZone: self.timeZone, currentTimeZone: userPreference.timeZone)
      formatter.locale = userPreference.locale

      formatter.appendMinute(startDate: self.date, endDate: end.date)
      formatter.appendTimeZone(
        eventTimeZone: self.timeZone,
        currentTimeZone: userPreference.timeZone
      )

      return (self.date..<end.date).formatted(formatter)
    }

    // Start value only
    var formatter = Date.FormatStyle.dateTime.hour()

    formatter.setTimeZone(eventTimeZone: self.timeZone, currentTimeZone: userPreference.timeZone)
    formatter.locale = userPreference.locale
    formatter.capitalizationContext = .beginningOfSentence

    formatter.appendMinute(startDate: self.date)
    formatter.appendTimeZone(
      eventTimeZone: self.timeZone,
      currentTimeZone: userPreference.timeZone
    )

    return self.date.formatted(formatter)
  }
}
