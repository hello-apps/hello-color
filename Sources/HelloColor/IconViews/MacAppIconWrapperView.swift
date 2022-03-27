import SwiftUI
import SwiftConvenience
import SwiftUIConvenience

public struct MacAppIconWrapperView<Content: View>: View {
  
  var view: Content
  
  public init(_ content: Content) {
    self.view = content
  }
  
  public var body: some View {
    GeometryReader { geometry in
      view
        .clipShape(MacAppIconShape())
        .padding(0.098 * geometry.size.minSide)
    }
  }
}
