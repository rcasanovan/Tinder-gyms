import ComposableArchitecture
import Foundation

/// A feature that represents a view with the gyms activities.
public struct LoadActivites: Reducer {
  @Dependency(\.apiClient) var apiClient

  public struct State: Equatable {
    /// Alert ot show a popup with a custom message
    var alert: LoadActivites.State.Alert?
    /// Indicates that we have a match. The default value is `false`
    var isMatchPresented = false
    /// The current matched gym. The default value is `nil`
    var matchedGym: LoadActivites.Gym?
    /// Total gyms received from the api client
    var totalGyms: Int = 0
    /// Total current likes
    var totalLikes: Int = 0
    /// The current network state for the feature
    var networkState: NetworkState<[LoadActivites.Gym], LoadActivites.Error>

    public init(networkState: NetworkState<[LoadActivites.Gym], LoadActivites.Error>) {
      self.networkState = networkState
    }

    /// Struct to manage a popup alert if needed
    public struct Alert: Identifiable, Equatable {
      public var id: String
      var title: String
      var message: String
    }

    /// The user gestures to manage specific actions
    public enum gestureAction {
      case discard
      case like
      case reload
    }
  }

  /// All TCA actions that we can receive from the view
  public enum Action: Equatable {
    /// An error was returned when the item list was fetched.
    case didReceiveError(Error)
    /// The full item list have been received.
    case didReceiveGyms(_ gyms: [LoadActivites.Gym])
    /// The user swiped a gym with a gesture action (discard or like).
    case didSwipe(gymId: LoadActivites.Gym.ID, gestureAction: LoadActivites.State.gestureAction)
    /// The user tapped on boost button.
    case didTapOnBoost
    /// The user tapped on refresh button.
    case didTapOnRefresh
    /// The user tapped on super like button.
    case didTapOnSuperLike
    /// The alert needs to be hidden.
    case hideAlert
    /// The match view needs to be hidden.
    case hideMatch
    /// Executed every time the Load Activities is on display.
    /// It reloads the screen if the network state is ready and contains a list of items.
    case onAppear
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didReceiveError(let error):
        state.networkState = .completed(.failure(error))
        return .none

      case .didReceiveGyms(let gyms):
        state.totalGyms = gyms.count
        state.networkState = .completed(.success(gyms))
        return .none

      case .didSwipe(let gymId, let gestureAction):
        guard case .completed(.success(let currentGyms)) = state.networkState else {
          return .none
        }

        switch gestureAction {
        case .discard:
          var gyms = currentGyms
          if let index = gyms.firstIndex(where: { $0.id == gymId }) {
            gyms.remove(at: index)
          }

          state.networkState = .completed(.success(gyms))
        case .like:
          var gyms = currentGyms
          if let index = gyms.firstIndex(where: { $0.id == gymId }) {
            state.matchedGym = gyms[index]
            state.totalLikes = state.totalLikes + 1
            gyms.remove(at: index)
          }

          state.networkState = .completed(.success(gyms))

          // Check if 10% of gyms have .liked state
          if matchFound(totalLikes: state.totalLikes, totalGyms: state.totalGyms) {
            state.isMatchPresented = true
          }
          break
        default:
          break
        }

        return .none

      case .didTapOnBoost:
        // Set the alert to show
        state.alert = LoadActivites.State.Alert(
          id: "boost_alert",
          title: "¡Boost!",
          message: "This functionality is not implemented in the demo"
        )
        return .none

      case .didTapOnRefresh:
        // If we need to refresh the view, we should reset the initial state
        state.networkState = .loading
        state.totalLikes = 0
        state.totalGyms = 0
        return self.loadEffect()

      case .didTapOnSuperLike:
        // Set the alert to show
        state.alert = LoadActivites.State.Alert(
          id: "super_like_alert",
          title: "¡Super like!",
          message: "This functionality is not implemented in the demo"
        )
        return .none

      case .hideAlert:
        state.alert = nil
        return .none

      case .hideMatch:
        state.isMatchPresented = false
        state.matchedGym = nil
        // Set the total likes to 0 in order to show it again if needed
        // (10% of gyms have .liked state)
        state.totalLikes = 0
        return .none

      case .onAppear:
        guard case .ready = state.networkState else {
          return .none
        }

        state.networkState = .loading
        return self.loadEffect()
      }
    }
  }
}

extension LoadActivites {
  /// Returns a boolean indicating if we have a match.
  /// A match should appear if we have 10% of gyms with a .liked state
  fileprivate func matchFound(totalLikes: Int, totalGyms: Int) -> Bool {
    // Check if 10% of gyms have a like
    totalLikes == Int(Double(totalGyms) * 0.1)
  }

  /// Returns an Effect that contains the gym list.
  /// In case of an error, the method will return the error.
  fileprivate func loadEffect() -> Effect<LoadActivites.Action> {
    return .run { send in
      let result = await apiClient.getGyms()
      switch result {
      case .success(let gyms):
        let items = gyms.map {
          LoadActivites.Gym(gymAPIDataModel: $0)
        }
        return await send(.didReceiveGyms(items.reversed()))
      case .failure(let error):
        return await send(.didReceiveError(.cannotLoadGyms(error: error.localizedDescription)))
      }
    } catch: { error, send in
      return await send(.didReceiveError(.cannotLoadGyms(error: error.localizedDescription)))
    }
  }
}

// MARK: Errors

extension LoadActivites {
  public enum Error: Swift.Error, Equatable {
    case cannotLoadGyms(error: String)
  }
}
