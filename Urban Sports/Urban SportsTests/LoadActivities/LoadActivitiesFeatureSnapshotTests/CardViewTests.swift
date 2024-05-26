import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class CardViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testCardView() {
    let view = CardView_Previews.Preview(gym: .mock)
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
