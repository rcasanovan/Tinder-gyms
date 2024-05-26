import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class FooterViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testFooterView() {
    let view = FooterView_Previews.Preview()

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
