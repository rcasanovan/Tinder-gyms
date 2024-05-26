import SwiftUI

// The cards view for the load activities feature
struct CardsView: View {
  let gyms: [LoadActivites.Gym]
  var onSwipe: ((LoadActivites.Gym.ID, LoadActivites.State.gestureAction) -> Void)

  var body: some View {
    ZStack {
      CardsEmptyView()
      ForEach(gyms) { gym in
        CardView(
          gym: gym,
          onSwipe: { gymId, swipeGesture in
            onSwipe(gymId, swipeGesture)
          }
        )
      }
    }
    .padding(8)
    .zIndex(1.0)
  }
}

#if DEBUG

// MARK: Previews

struct CardsView_Previews: PreviewProvider {
  struct Preview: View {
    let gyms: [LoadActivites.Gym]

    var body: some View {
      CardsView(
        gyms: gyms,
        onSwipe: { _, _ in }
      )
    }
  }

  static var previews: some View {
    Preview(gyms: .mock)
      .previewLayout(.sizeThatFits)
  }
}

#endif
