import Foundation

extension Date {
  /// Returns true if the main date components (day, month and year) are the same.
  ///
  /// Time is not considered to make this comparison.
  func isSameDate(anotherDate: Date, calendar: Calendar) -> Bool {
    let dateComponents: Set<Calendar.Component> = [.day, .month, .year]

    return calendar.dateComponents(dateComponents, from: self)
      == calendar.dateComponents(dateComponents, from: anotherDate)
  }

  /// Returns true if this time is on the hour (o'clock).
  ///
  /// This is typically used to drop zero minutes from the formatter.
  func isOClock(calendar: Calendar) -> Bool {
    calendar.component(.minute, from: self) == 0
  }
}
