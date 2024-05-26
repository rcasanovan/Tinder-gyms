import ComposableArchitecture
import CoreLocation
import SwiftUI

// The card view for the load activities feature
struct CardView: View {
  @Dependency(\.locationClient) var locationClient

  @State private var distance: CLLocationDistance? = nil
  @State var gym: LoadActivites.Gym

  let onSwipe: ((LoadActivites.Gym.ID, LoadActivites.State.gestureAction) -> Void)

  // MARK: - Drawing Constant
  let cardGradient = Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.5)])

  var body: some View {
    ZStack(alignment: .topLeading) {
      Image(gym.imagePath)
        .resizable()
        .clipped()

      // Linear Gradient
      LinearGradient(gradient: cardGradient, startPoint: .top, endPoint: .bottom)
      VStack(alignment: .leading) {
        Spacer()
        VStack(alignment: .leading) {
          HStack {
            VStack {
              Spacer()
              Text(gym.facilityTitle)
                .font(.title)
                .fontWeight(.bold)

            }
            VStack {
              Spacer()
              Text(gym.provinceCode)
                .font(.title)
            }
          }
          Text(gym.location)
            .font(.title2)
            .fontWeight(.bold)
          Text(gym.address)
            .font(.title3)
          HStack {
            VStack {
              TagView(title: gym.activity)
            }
            Spacer()
            VStack {
              if let distance = distance {
                Text(String(format: "%.1f km", distance / 1000))  // Convert meters to kilometers
                  .font(.body)
              } else {
                Text("-")
                  .font(.body)
                  .foregroundColor(.gray)
              }
            }
          }
          if let startDate = gym.startDate, let endDate = gym.endDate, let timeZone = gym.timeZone {
            DateView(start: startDate, end: endDate, timeZone: timeZone)
          }
        }
      }
      .padding()
      .foregroundColor(.white)

      HStack {
        Image("accept")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity(Double(gym.x / 10 - 1))
        Spacer()
        Image("discard")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 150)
          .opacity(Double(gym.x / 10 * -1 - 1))
      }

    }

    .cornerRadius(8)
    .offset(x: gym.x, y: gym.y)
    .rotationEffect(.init(degrees: gym.degree))
    .gesture(
      DragGesture()
        .onChanged { value in
          withAnimation(.default) {
            gym.x = value.translation.width
            // MARK: - BUG 5
            gym.y = value.translation.height
            gym.degree = 7 * (value.translation.width > 0 ? 1 : -1)
          }
        }
        .onEnded { (value) in
          withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
            switch value.translation.width {
            case 0...100:
              gym.x = 0
              gym.degree = 0
              gym.y = 0
            case let x where x > 100:
              gym.x = 500
              gym.degree = 12
              didSwipe(with: .like)
            case (-100)...(-1):
              gym.x = 0
              gym.degree = 0
              gym.y = 0
            case let x where x < -100:
              gym.x = -500
              gym.degree = -12
              didSwipe(with: .discard)
            default:
              gym.x = 0
              gym.y = 0
            }
          }
        }
    )
    .onAppear {
      calculateDistance()
    }
  }
}

extension CardView {
  fileprivate func didSwipe(with gesture: LoadActivites.State.gestureAction) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      onSwipe(gym.id, gesture)
    }
  }

  fileprivate func calculateDistance() {
    Task {
      if let distance = await locationClient.distanceTo(
        placeName: gym.location,
        address: gym.address,
        provinceCode: gym.provinceCode,
        postalCode: gym.postalCode
      ) {
        self.distance = distance
      }
    }
  }
}

#if DEBUG

// MARK: Previews

struct CardView_Previews: PreviewProvider {
  struct Preview: View {
    let gym: LoadActivites.Gym

    var body: some View {
      CardView(
        gym: gym,
        onSwipe: { _, _ in }
      )
    }
  }

  static var previews: some View {
    Preview(gym: .mock)
      .previewLayout(.sizeThatFits)
  }
}

#endif
