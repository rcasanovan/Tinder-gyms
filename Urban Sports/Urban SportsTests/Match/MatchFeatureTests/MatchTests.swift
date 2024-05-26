import ComposableArchitecture
import SwiftUI
import XCTest

@testable import Urban_Sports

@MainActor
final class MatchTests: XCTestCase {
  func testDidTapOnClose() async {
    // Given
    let parentStore = Store(
      initialState: .success,
      reducer: {
        LoadActivites()
      }
    )

    // When
    let store = TestStore(
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
          parentStore: parentStore
        )
    ) {
      Match()
    }

    // Then
    await store.send(.didTapOnClose)
  }
}
