import SwiftUI

// The tag view for the load activities feature
struct TagView: View {
  let title: String

  var body: some View {
    Text(title)
      .font(.body)
      .frame(height: 18)
      .padding(.horizontal, 14)
      .padding(.vertical, 7)
      .background(.blue)
      .foregroundColor(.white)
      .cornerRadius(18)
  }
}

#if DEBUG

// MARK: Previews

struct TagsView_Previews: PreviewProvider {
  struct Preview: View {
    let title: String

    var body: some View {
      TagView(title: title)
    }
  }

  static var previews: some View {
    Preview(title: "Basketball")
      .previewLayout(.sizeThatFits)
  }
}

#endif
