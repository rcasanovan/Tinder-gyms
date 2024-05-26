import Foundation

extension Locale {
  /// Returns whether the user has configured the 24h hour cycle.
  ///
  /// This is only available on iOS 16, so on earlier versions it will return nil because this data is unknown.
  var uses24HourClock: Bool? {
    if #available(iOS 16, *) {
      return self.hourCycle == .zeroToTwentyThree || self.hourCycle == .oneToTwentyFour
    }
    return nil
  }
}
