import ComposableArchitecture
import Foundation

/// A feature that represents a view with a gym match.
public struct Match: Reducer {

  public struct State: Equatable {
    /// The current gym information
    var gym: LoadActivites.Gym?
    /// The parent store to send actions to the parent if needed
    var parentStore: Store<LoadActivites.State, LoadActivites.Action>

    public init(gym: LoadActivites.Gym?, parentStore: Store<LoadActivites.State, LoadActivites.Action>) {
      self.gym = gym
      self.parentStore = parentStore
    }
  }

  public enum Action: Equatable {
    /// The user tapped on close button.
    case didTapOnClose
  }

  public var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .didTapOnClose:
        // Send a message to the parent in order to avoid to show the match view again in a loop
        state.parentStore.send(.hideMatch)
        return .none
      }
    }
  }
}
