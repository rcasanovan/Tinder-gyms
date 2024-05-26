import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class CardsViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testCardsView() {
    let view = CardsView_Previews.Preview(gyms: .mock)
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
