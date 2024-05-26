import ComposableArchitecture
import SwiftUI

struct LoadActivitesView: View {
  private var store: Store<LoadActivites.State, LoadActivites.Action>

  public init(store: Store<LoadActivites.State, LoadActivites.Action>) {
    self.store = store
  }

  @ViewBuilder
  private var content: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      switch viewStore.networkState {
      case .loading:
        placeholder()
      case let .completed(.success(gyms)):
        VStack {
          HeaderView()
          CardsView(
            gyms: gyms,
            onSwipe: { gymId, swipeGesture in
              viewStore.send(.didSwipe(gymId: gymId, gestureAction: swipeGesture))
            }
          )
          FooterView(
            gymId: gyms.last?.id,
            isUserInteractionEnabled: true,
            didTapOnDiscard: { gymId in
              viewStore.send(.didSwipe(gymId: gymId, gestureAction: .discard))
            },
            didTapOnLike: { gymId in
              viewStore.send(.didSwipe(gymId: gymId, gestureAction: .like))
            },
            didTapOnRefresh: {
              viewStore.send(.didTapOnRefresh)
            },
            didTapOnBoost: {
              viewStore.send(.didTapOnBoost)
            },
            didTapOnSuperLike: {
              viewStore.send(.didTapOnSuperLike)
            }
          )
        }
      case let .completed(.failure(error)):
        VStack {
          Spacer()
          ErrorView(
            error: error.localizedDescription,
            didTapOnReload: {
              viewStore.send(.didTapOnRefresh)
            }
          )
          Spacer()
          FooterView(
            gymId: "_id_",
            isUserInteractionEnabled: false,
            didTapOnDiscard: { _ in },
            didTapOnLike: { _ in },
            didTapOnRefresh: {},
            didTapOnBoost: {},
            didTapOnSuperLike: {}
          )
        }
      case .ready:
        Color.clear
      }

    }
  }

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      content
        .onAppear { viewStore.send(.onAppear) }
        .alert(
          item: viewStore.binding(
            get: { $0.alert },
            send: .hideAlert
          )
        ) { alert in
          Alert(
            title: Text(alert.title),
            message: Text(alert.message),
            dismissButton: .default(Text("OK"))
          )
        }
        .sheet(
          isPresented: viewStore.binding(
            get: { $0.isMatchPresented },
            send: .hideMatch
          )
        ) {
          MatchView(
            store: .init(
              initialState: .init(gym: viewStore.matchedGym, parentStore: self.store),
              reducer: {
                Match()
              }
            )
          )
        }
    }
  }
}

extension LoadActivitesView {
  fileprivate func placeholder() -> some View {
    VStack {
      HeaderView()
      CardView(
        gym: LoadActivites.Gym(
          id: "_id_",
          facilityTitle: "_facilityTitle_",
          location: "_location_",
          address: "_address_",
          provinceCode: "_NC_",
          postalCode: "_postal_code_",
          activity: "_activity_",
          imagePath: ""
        ),
        onSwipe: { _, _ in }
      )
      .redacted(reason: .placeholder)
      FooterView(
        gymId: "_id_",
        isUserInteractionEnabled: false,
        didTapOnDiscard: { _ in },
        didTapOnLike: { _ in },
        didTapOnRefresh: {},
        didTapOnBoost: {},
        didTapOnSuperLike: {}
      )
    }
  }
}

#if DEBUG

// MARK: Previews

struct LoadActivitiesView_Previews: PreviewProvider {
  struct Preview: View {
    var store: Store<LoadActivites.State, LoadActivites.Action>
    var body: some View {
      LoadActivitesView(store: store)
    }
  }

  static var previews: some View {
    Preview(
      store: .init(
        initialState: .success
      ) {
        LoadActivites()
      }
    )
    .previewLayout(.sizeThatFits)
    .previewDisplayName("Succcess state")

    Preview(
      store: .init(
        initialState: .loading
      ) {
        LoadActivites()
      }
    )
    .previewLayout(.sizeThatFits)
    .previewDisplayName("Loading state")

    Preview(
      store: .init(
        initialState: .failure
      ) {
        LoadActivites()
      }
    )
    .previewLayout(.sizeThatFits)
    .previewDisplayName("Error state")
  }
}

#endif
