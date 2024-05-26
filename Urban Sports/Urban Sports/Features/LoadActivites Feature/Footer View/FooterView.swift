import SwiftUI

// The footer view for the load activities feature
struct FooterView: View {
  let gymId: LoadActivites.Gym.ID?
  let isUserInteractionEnabled: Bool
  let didTapOnDiscard: ((LoadActivites.Gym.ID) -> Void)
  let didTapOnLike: ((LoadActivites.Gym.ID) -> Void)
  let didTapOnRefresh: (() -> Void)
  let didTapOnBoost: (() -> Void)
  let didTapOnSuperLike: (() -> Void)

  var body: some View {
    HStack(spacing: 0) {
      Button(action: {
        didTapOnRefresh()
      }) {
        Image("refresh")
          .resizable()
          .frame(width: 70, height: 70)
      }
      Button(action: {
        if let gymId {
          didTapOnDiscard(gymId)
        }
      }) {
        Image("dismiss")
          .resizable()
          .frame(width: 70, height: 70)
      }
      Button(action: {
        didTapOnSuperLike()
      }) {
        Image("super_like")
          .resizable()
          .frame(width: 70, height: 70)
      }
      Button(action: {
        if let gymId {
          didTapOnLike(gymId)
        }
      }) {
        Image("like")
          .resizable()
          .frame(width: 70, height: 70)
      }
      Button(action: {
        didTapOnBoost()
      }) {
        Image("boost")
          .resizable()
          .frame(width: 70, height: 70)
      }
    }
    .allowsHitTesting(isUserInteractionEnabled)
  }
}

#if DEBUG

// MARK: Previews

struct FooterView_Previews: PreviewProvider {
  struct Preview: View {
    var body: some View {
      FooterView(
        gymId: "_id_",
        isUserInteractionEnabled: true,
        didTapOnDiscard: { _ in },
        didTapOnLike: { _ in },
        didTapOnRefresh: {},
        didTapOnBoost: {},
        didTapOnSuperLike: {}
      )
    }
  }

  static var previews: some View {
    Preview()
      .previewLayout(.sizeThatFits)
  }
}

#endif
