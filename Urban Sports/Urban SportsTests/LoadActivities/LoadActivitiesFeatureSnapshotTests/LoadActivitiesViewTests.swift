import ComposableArchitecture
import SnapshotTesting
import SwiftUI
import XCTest

@testable import Urban_Sports

final class LoadActivitiesViewTests: XCTestCase {
  override func setUpWithError() throws {
    //    isRecording = true
  }

  func testLoadActivitiesViewLoadingState() {
    let store = Store<LoadActivites.State, LoadActivites.Action>(
      initialState: .loading
    ) {
      LoadActivites()
    }

    let view =
      LoadActivitiesView_Previews.Preview(
        store: store
      )
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

  func testLoadActivitiesViewSuccessState() {
    let store = Store<LoadActivites.State, LoadActivites.Action>(
      initialState: .success
    ) {
      LoadActivites()
    }

    let view =
      LoadActivitiesView_Previews.Preview(
        store: store
      )
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

  func testLoadActivitiesViewFailureState() {
    let store = Store<LoadActivites.State, LoadActivites.Action>(
      initialState: .failure
    ) {
      LoadActivites()
    }

    let view =
      LoadActivitiesView_Previews.Preview(
        store: store
      )
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }

  func testLoadActivitiesViewSuccessStateWithNoGyms() {
    let store = Store<LoadActivites.State, LoadActivites.Action>(
      initialState: LoadActivites.State(networkState: .completed(.success([])))
    ) {
      LoadActivites()
    }

    let view =
      LoadActivitiesView_Previews.Preview(
        store: store
      )
      .environment(\.locale, .init(identifier: "en_US"))
      .environment(\.timeZone, TimeZone(identifier: "GMT")!)
      .environment(\.calendar, .init(identifier: .gregorian))

    assertSnapshot(matching: view.colorScheme(.light), as: .deviceImage(), named: "light")
    assertSnapshot(matching: view.colorScheme(.dark), as: .deviceImage(), named: "dark")
  }
}
