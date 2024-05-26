import Foundation

/// Encapsules event date information (start or end date).
///
/// Both date and time zone are required to create an ``EventDate``.
/// If any of these are nil ``EventDate`` will be `nil`.
public struct EventDate {
  let date: Foundation.Date
  let timeZone: TimeZone

  public init?(date: Date?, timeZone: TimeZone?) {
    guard let date, let timeZone else { return nil }
    self.date = date
    self.timeZone = timeZone
  }
}
