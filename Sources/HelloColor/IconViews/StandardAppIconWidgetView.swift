import SwiftUI
import SwiftUIConvenience

public struct StandardAppIconWidgetView: View {
  
  let characterView: AnyView
  var accentColor: HelloColor
  
  public init<CharacterView: View>(characterView: CharacterView, accentColor: HelloColor) {
    self.characterView = AnyView(characterView)
    self.accentColor = accentColor
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        HelloColor.dark.swiftuiColor
        ContainerRelativeShape()
          .strokeBorder(lineWidth: 0.03 * geometry.size.minSide)
          .foregroundStyle(LinearGradient(stops: [.init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0),
                                                  .init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0.72),
                                                  .init(color: accentColor.swiftuiColor, location: 0.9),
                                                  .init(color: accentColor.swiftuiColor, location: 1)],
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing))
          //.padding(0.03 * geometry.size.minSide)
        
        ContainerRelativeShape()
          .strokeBorder(lineWidth: 0.03 * geometry.size.minSide)
          .foregroundStyle(LinearGradient(stops: [.init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0),
                                                  .init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0.72),
                                                  .init(color: accentColor.swiftuiColor, location: 0.9),
                                                  .init(color: accentColor.swiftuiColor, location: 1)],
                                          startPoint: .bottomTrailing,
                                          endPoint: .topLeading))
        characterView
          .frame(width: geometry.size.minSide, height: geometry.size.minSide)
      }.frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}
