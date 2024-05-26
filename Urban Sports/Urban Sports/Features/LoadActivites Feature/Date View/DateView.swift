import SwiftUI

// The date view for the load activities feature
struct DateView: View {
  @Environment(\.calendar) var calendar
  @Environment(\.timeZone) var currentTimeZone
  @Environment(\.currentDate) var currentDate
  @Environment(\.locale) var locale

  let start: Date
  let end: Date
  let timeZone: TimeZone

  var date: String? {
    EventDate(date: start, timeZone: timeZone)?
      .dateOnly(
        end: nil,
        userPreference: .init(calendar: calendar, locale: locale, timeZone: currentTimeZone),
        now: currentDate
      )
  }

  var time: String? {
    EventDate(date: start, timeZone: timeZone)?
      .timeOnly(
        end: nil,
        userPreference: .init(calendar: calendar, locale: locale, timeZone: currentTimeZone)
      )
  }

  var body: some View {
    VStack {
      if let date, let time {
        HStack {
          Text("\(date) · \(time)")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
          Spacer()
        }
      }

      if let duration = formattedDuration(startDate: start, endDate: end) {
        HStack(alignment: .top, spacing: 8) {
          Image("duration")
            .foregroundColor(.white)
          VStack(alignment: .leading, spacing: 8) {
            duration
              .font(.body)
              .foregroundColor(.white)
              .fixedSize(horizontal: false, vertical: true)
          }
          Spacer()
        }
      }
    }
  }
}

extension DateView {
  /// Returns a Text with the duration of the event or nil if it's not possible to generate the format
  ///
  /// Usage for a date only date (no range):
  /// ```
  /// let starDate = Date(timeIntervalSince1970: 1_703_152_800)
  /// let endDate = Date(timeIntervalSince1970: 1_703_152_800)
  /// Duration: '4 hours 30 minutes'
  ///
  /// let starDate = Date(timeIntervalSince1970: 1_703_152_800)
  /// let endDate = Date(timeIntervalSince1970: 1_703_156_400)
  /// Duration: '1 hour'
  ///
  /// let starDate = Date(timeIntervalSince1970: 1_703_152_800)
  /// let endDate = Date(timeIntervalSince1970: 1_703_155_500)
  /// Duration: '45 minutes'
  ///
  /// let starDate = Date(timeIntervalSince1970: 1_703_152_800)
  /// let endDate = Date(timeIntervalSince1970: 1_703_163_660)
  /// Duration: '3 hours 1 minute'
  /// ```
  ///
  /// - Parameters:
  ///   - startDate: event start date.
  ///   - endDate: event end date.
  /// - Returns: a displayable Text with the event duration
  fileprivate func formattedDuration(startDate: Date?, endDate: Date?) -> Text? {
    guard let startDate = startDate, let endDate = endDate else { return nil }

    let components = calendar.dateComponents([.day, .hour, .minute], from: startDate, to: endDate)
    var formattedComponents: [Text] = []

    if let days = components.day, days > 0 {
      formattedComponents.append(Text("\(days) day(s)"))
    }
    if let hours = components.hour, hours > 0 {
      formattedComponents.append(Text("\(hours) hour(s)"))
    }
    if let minutes = components.minute, minutes > 0 {
      formattedComponents.append(Text("\(minutes) minute(s)"))
    }

    if formattedComponents.isEmpty { return nil }

    var formattedDuration = Text("")
    for (index, text) in formattedComponents.enumerated() {
      if index == 0 {
        formattedDuration = text
      } else {
        formattedDuration = formattedDuration + Text(" ") + text
      }
    }

    return formattedDuration
  }

}

#if DEBUG

// MARK: Previews

struct DateView_Previews: PreviewProvider {
  private enum Mock {
    static let start = Date(timeIntervalSince1970: 1_703_152_800)
    static let end = Date(timeIntervalSince1970: 1_703_161_800)
    static let timeZone = TimeZone(secondsFromGMT: 0)!
  }

  struct Preview: View {
    let start: Date
    let end: Date
    let timeZone: TimeZone

    var body: some View {
      DateView(start: start, end: end, timeZone: timeZone)
        .background(.black)
    }
  }

  static var previews: some View {
    Preview(start: Mock.start, end: Mock.end, timeZone: Mock.timeZone)
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))
      .previewLayout(.sizeThatFits)
  }
}

#endif
