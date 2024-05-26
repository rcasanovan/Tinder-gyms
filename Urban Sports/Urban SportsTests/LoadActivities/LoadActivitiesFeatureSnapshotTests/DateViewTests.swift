import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class DateViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testDateView() {
    let start = Date(timeIntervalSince1970: 1_703_152_800)
    let end = Date(timeIntervalSince1970: 1_703_161_800)
    let timeZone = TimeZone(secondsFromGMT: 0)!

    let view = DateView_Previews.Preview(start: start, end: end, timeZone: timeZone)
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
