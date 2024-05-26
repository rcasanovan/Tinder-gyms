import SwiftUI

// The error view for the load activities feature
struct ErrorView: View {
  let error: String
  let didTapOnReload: (() -> Void)

  var body: some View {
    VStack(alignment: /*@START_MENU_TOKEN@*/ .center /*@END_MENU_TOKEN@*/) {
      Image("error")
        .resizable()
        .frame(width: 80, height: 80)

      Text("Something went wrong. Please try again")
        .foregroundColor(.black)
        .font(.title2)
        .fontWeight(.light)
        .padding(.horizontal, 40)
        .multilineTextAlignment(.center)

      VStack {
        Text(error)
          .foregroundColor(.white)
          .font(.title3)
          .fontWeight(.light)
          .padding(.horizontal, 10)
          .multilineTextAlignment(.center)
          .padding()
      }
      .background(.gray)
      .cornerRadius(12)
      .padding(.horizontal, 40)
      .padding(.top, 10)

      Button(
        action: {
          didTapOnReload()
        },
        label: {
          Text("reload")
            .foregroundColor(.white)
            .padding(10)
            .background(Color.blue)
            .cornerRadius(10)
        }
      )
      .padding(.top, 20)
    }
  }
}

#if DEBUG

// MARK: Previews

struct ErrorView_Previews: PreviewProvider {
  struct Preview: View {
    var body: some View {
      ErrorView(
        error: "Localized description for the error",
        didTapOnReload: {}
      )
    }
  }

  static var previews: some View {
    Preview()
  }
}

#endif
