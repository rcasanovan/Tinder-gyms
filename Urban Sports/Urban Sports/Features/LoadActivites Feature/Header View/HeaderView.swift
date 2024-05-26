import SwiftUI

// The header view for the load activities feature
struct HeaderView: View {
  var body: some View {
    HStack {
      Spacer()
      Image("main_icon")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 45)
        .padding()
      Spacer()
    }
    .padding([.horizontal, .bottom])
  }
}

#if DEBUG

// MARK: Previews

struct HeaderView_Previews: PreviewProvider {
  struct Preview: View {
    var body: some View {
      HeaderView()
    }
  }

  static var previews: some View {
    Preview()
  }
}

#endif
