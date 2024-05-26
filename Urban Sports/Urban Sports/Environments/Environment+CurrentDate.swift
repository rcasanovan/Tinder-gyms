import SwiftUI

// Environment for the current day
private struct CurrentDateKey: EnvironmentKey {
  static var defaultValue: Date = Date.now
}

extension EnvironmentValues {
  public var currentDate: Date {
    get { self[CurrentDateKey.self] }
    set { self[CurrentDateKey.self] = newValue }
  }
}
