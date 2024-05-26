import ComposableArchitecture
import SwiftUI
import XCTest

@testable import Urban_Sports

@MainActor
final class LoadActivitiesTests: XCTestCase {
  func testOnAppearDidReceiveGyms() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    let apiDataModelResponse: [GymAPIDataModel] = .mock

    let gyms: [LoadActivites.Gym] =
      apiDataModelResponse.map {
        LoadActivites.Gym(gymAPIDataModel: $0)
      }
      .reversed()

    // Then
    await store.receive(.didReceiveGyms(gyms)) {
      $0.totalGyms = gyms.count
      $0.networkState = .completed(.success(gyms))
    }
  }

  func testOnAppearDidReceiveError() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    } withDependencies: { dependencies in
      dependencies.apiClient = APIClient.failureMock
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    // Then
    await store.receive(
      .didReceiveError(.cannotLoadGyms(error: "The operation couldn’t be completed. (Urban_Sports.APIError error 0.)"))
    ) {
      $0.networkState = .completed(
        .failure(.cannotLoadGyms(error: "The operation couldn’t be completed. (Urban_Sports.APIError error 0.)"))
      )
    }
  }

  func testOnAppearDidTapOnBoost() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // Then
    await store.send(.didTapOnBoost) {
      $0.alert = LoadActivites.State.Alert(
        id: "boost_alert",
        title: "¡Boost!",
        message: "This functionality is not implemented in the demo"
      )
    }
  }

  func testOnAppearDidTapOnSuperLike() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // Then
    await store.send(.didTapOnSuperLike) {
      $0.alert = LoadActivites.State.Alert(
        id: "super_like_alert",
        title: "¡Super like!",
        message: "This functionality is not implemented in the demo"
      )
    }
  }

  func testOnAppearDidTapOnRefresh() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    let apiDataModelResponse: [GymAPIDataModel] = .mock

    let gyms: [LoadActivites.Gym] =
      apiDataModelResponse.map {
        LoadActivites.Gym(gymAPIDataModel: $0)
      }
      .reversed()

    // When
    await store.send(.didTapOnRefresh) {
      $0.networkState = .loading
      $0.totalLikes = 0
      $0.totalGyms = 0
    }

    // Then
    await store.receive(.didReceiveGyms(gyms)) {
      $0.totalGyms = gyms.count
      $0.networkState = .completed(.success(gyms))
    }
  }

  func testOnAppearHideAlert() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // When
    await store.send(.didTapOnSuperLike) {
      $0.alert = LoadActivites.State.Alert(
        id: "super_like_alert",
        title: "¡Super like!",
        message: "This functionality is not implemented in the demo"
      )
    }

    // Then
    await store.send(.hideAlert) {
      $0.alert = nil
    }
  }

  func testOnAppearDidSwipeDiscard() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    let apiDataModelResponse: [GymAPIDataModel] = .mock

    let gyms: [LoadActivites.Gym] =
      apiDataModelResponse.map {
        LoadActivites.Gym(gymAPIDataModel: $0)
      }
      .reversed()

    var gymsAfterDiscard = gyms
    gymsAfterDiscard.remove(at: 0)

    // Then
    await store.receive(.didReceiveGyms(gyms)) {
      $0.totalGyms = gyms.count
      $0.networkState = .completed(.success(gyms))
    }

    await store.send(.didSwipe(gymId: gyms.first!.id, gestureAction: .discard)) {
      $0.networkState = .completed(.success(gymsAfterDiscard))
    }
  }

  func testOnAppearDidSwipeLike() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    let apiDataModelResponse: [GymAPIDataModel] = .mock

    let gyms: [LoadActivites.Gym] =
      apiDataModelResponse.map {
        LoadActivites.Gym(gymAPIDataModel: $0)
      }
      .reversed()

    var gymsAfterLike = gyms
    gymsAfterLike.remove(at: 0)

    // Then
    await store.receive(.didReceiveGyms(gyms)) {
      $0.totalGyms = gyms.count
      $0.networkState = .completed(.success(gyms))
    }

    await store.send(.didSwipe(gymId: gyms.first!.id, gestureAction: .like)) {
      $0.matchedGym = gyms.first!
      $0.totalLikes = 1
      $0.networkState = .completed(.success(gymsAfterLike))
    }
  }

  func testOnAppearDidSwipeLikeWithMatch() async {
    // Given
    let store = TestStore(
      initialState: LoadActivites.State(networkState: .ready)
    ) {
      LoadActivites()
    }

    // When
    await store.send(.onAppear) {
      $0.networkState = .loading
    }

    let apiDataModelResponse: [GymAPIDataModel] = .mock

    let gyms: [LoadActivites.Gym] =
      apiDataModelResponse.map {
        LoadActivites.Gym(gymAPIDataModel: $0)
      }
      .reversed()

    var gymsAfterLike = gyms
    gymsAfterLike.remove(at: 0)

    let firstGymID = gyms[0].id
    let secondGymID = gyms[1].id

    // Then
    await store.receive(.didReceiveGyms(gyms)) {
      $0.totalGyms = gyms.count
      $0.networkState = .completed(.success(gyms))
    }

    await store.send(.didSwipe(gymId: firstGymID, gestureAction: .like)) {
      $0.matchedGym = gyms[0]
      $0.totalLikes = 1
      $0.networkState = .completed(.success(gymsAfterLike))
    }

    gymsAfterLike.remove(at: 0)

    await store.send(.didSwipe(gymId: secondGymID, gestureAction: .like)) {
      $0.matchedGym = gyms[1]
      $0.totalLikes = 2
      $0.isMatchPresented = true
      $0.networkState = .completed(.success(gymsAfterLike))
    }
  }
}
