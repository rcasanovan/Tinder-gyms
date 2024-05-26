import ComposableArchitecture
import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class MatchViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testMatchView() {
    let store = Store<Match.State, Match.Action>(
      initialState:
        .init(
          gym: LoadActivites.Gym(
            id: "1",
            facilityTitle: "Fitness Center",
            location: "Gym Floor",
            address: "777 Oak Street",
            provinceCode: "NC",
            postalCode: "10021",
            activity: "Basketball",
            imagePath: "test_image_0"
          ),
          parentStore: .init(
            initialState: .success,
            reducer: {
              LoadActivites()
            }
          )
        )
    ) {
      Match()
    }

    let view = MatchView_Previews.Preview(
      store: store
    )
    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
