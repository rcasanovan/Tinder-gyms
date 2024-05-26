import SwiftUI

// The cards empty view for the load activities feature
struct CardsEmptyView: View {
  var body: some View {
    VStack {
      Spacer()
      Text("No more gyms to show")
        .font(.body)
        .foregroundColor(.black)
      Spacer()
    }
  }
}

#if DEBUG

// MARK: Previews

struct CardsEmptyView_Previews: PreviewProvider {
  static var previews: some View {
    CardsEmptyView()
  }
}

#endif
