import ComposableArchitecture
import SwiftUI

struct MatchView: View {
  private var store: Store<Match.State, Match.Action>
  @State private var animationAmount: CGFloat = 1

  public init(store: Store<Match.State, Match.Action>) {
    self.store = store
  }

  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        HStack {
          Image(systemName: "heart.fill")
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.red)
            .scaleEffect(animationAmount)
            .animation(
              .linear(duration: 0.1)
                .delay(0.2)
                .repeatForever(autoreverses: true),
              value: animationAmount
            )
            .onAppear {
              animationAmount = 1.2
            }

          Image("match")
            .resizable()
            .frame(width: 250, height: 93)
        }

        if let gym = viewStore.gym {
          HStack {
            Image(gym.imagePath)
              .resizable()
              .frame(width: 80, height: 80)
              .cornerRadius(40)

            VStack(alignment: .leading) {
              Text(gym.location)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.black)
              Text(gym.address)
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.black)
            }
          }
        }

        Button(
          action: { viewStore.send(.didTapOnClose) },
          label: {
            Text("Continue playing")
              .foregroundColor(.white)
              .padding()
              .background(Color.blue)
              .cornerRadius(10)
          }
        )
      }
    }
  }
}

#if DEBUG

// MARK: Previews

struct MatchView_Previews: PreviewProvider {
  struct Preview: View {
    var store: Store<Match.State, Match.Action>
    var body: some View {
      MatchView(store: store)
    }
  }

  static var previews: some View {
    NavigationView {
      Preview(
        store: .init(
          initialState: .init(
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
      )
    }
  }
}

#endif
