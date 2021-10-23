import SwiftUI

public struct StandardAppIconView: View {
  
  let characterView: AnyView
  var accentColor: HelloColor
  
  public init<CharacterView: View>(characterView: CharacterView, accentColor: HelloColor) {
    self.characterView = AnyView(characterView)
    self.accentColor = accentColor
  }
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        VStack(spacing: 0) {
          HelloColor.dark.swiftuiColor
            .frame(height: 0.74 * geometry.size.minSide)
          accentColor.swiftuiColor
        }
        
        characterView
          .frame(width: geometry.size.minSide, height: geometry.size.minSide)
      }.frame(width: geometry.size.minSide, height: geometry.size.minSide)
    }
  }
}
