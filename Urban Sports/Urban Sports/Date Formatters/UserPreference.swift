import Foundation

/// Encapsules user preferences that have an impact on date formatting.
///
/// Use `timeZone` for the current user time zone and locale for the current user locale (device user settings).
public struct UserPreference {
  public let calendar: Calendar
  public let locale: Locale
  public let timeZone: TimeZone

  public init(calendar: Calendar, locale: Locale, timeZone: TimeZone) {
    self.calendar = calendar
    self.locale = locale
    self.timeZone = timeZone
  }
}
