import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class TagViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testTagView() {
    let view = TagsView_Previews.Preview(title: "Basketball")

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
