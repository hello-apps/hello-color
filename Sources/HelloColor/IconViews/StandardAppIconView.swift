import SwiftUI
import SwiftUIConvenience

struct StandardIconBottomCurve: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.minX, y: 0.74 * rect.maxY))
    path.addCurve(to: CGPoint(x: rect.maxX, y: 0.74 * rect.maxY),
                  control1: CGPoint(x: 0.025 * rect.maxX, y: 0.76 * rect.maxY),
                  control2: CGPoint(x: 0.975 * rect.maxX, y: 0.76 * rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.closeSubpath()
    
    return path
  }
}


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
//        RadialGradient(stops: [.init(color: HelloColor.dark.swiftuiColor, location: 0),
//                               //.init(color: HelloColor.dark.swiftuiColor, location: 0.1),
//                               .init(color: accentColor.swiftuiColor, location: 0.76),
//                               .init(color: accentColor.swiftuiColor, location: 1)],
//                       center: .center, startRadius: 0.25 * geometry.size.minSide,
//                       endRadius: geometry.size.minSide)
//        LinearGradient(stops: [.init(color: HelloColor.dark.swiftuiColor, location: 0),
//                               .init(color: HelloColor.dark.swiftuiColor, location: 0.6),
//                               //.init(color: accentColor.swiftuiColor, location: 0.76),
//                               .init(color: accentColor.swiftuiColor, location: 0.9),
//                               .init(color: accentColor.swiftuiColor, location: 1)],
//                       startPoint: .top,
//                       endPoint: .bottom)
        HelloColor.dark.swiftuiColor
        AppIconShape()
          .strokeBorder(lineWidth: 0.03 * geometry.size.minSide)
          .foregroundStyle(LinearGradient(stops: [.init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0),
                                                  .init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0.72),
                                                  .init(color: accentColor.swiftuiColor, location: 0.9),
                                                  .init(color: accentColor.swiftuiColor, location: 1)],
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing))
          .padding(0.03 * geometry.size.minSide)
        
//        AppIconShape()
//          .strokeBorder(lineWidth: 0.03 * geometry.size.minSide)
//          .foregroundStyle(LinearGradient(stops: [.init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0),
//                                                  .init(color: HelloColor.dark.swiftuiColor.opacity(0), location: 0.72),
//                                                  .init(color: accentColor.swiftuiColor, location: 0.9),
//                                                  .init(color: accentColor.swiftuiColor, location: 1)],
//                                          startPoint: .bottomTrailing,
//                                          endPoint: .topLeading))
          //.padding(0.03 * geometry.size.minSide)
        
//        Capsule(style: .continuous)
//          .fill(accentColor.swiftuiColor)
//          .frame(width: 0.4 * geometry.size.minSide, height: 0.03 * geometry.size.minSide)
//          .padding(.bottom, 0.03 * geometry.size.minSide)
//          .frame(height: geometry.size.minSide, alignment: .bottom)
        
//          .shadow(color: accentColor.swiftuiColor, radius: 0.01 * geometry.size.minSide)
//          .shadow(color: accentColor.swiftuiColor, radius: 0.025 * geometry.size.minSide)
//          //.frame(height: 0.74 * geometry.size.minSide)
//        StandardIconBottomCurve()
//          .fill(accentColor.swiftuiColor)
//        VStack(spacing: 0) {
//          HelloColor.dark.swiftuiColor
//            .frame(height: 0.74 * geometry.size.minSide)
//          accentColor.swiftuiColor
//        }
        
        characterView
          .frame(width: geometry.size.minSide, height: geometry.size.minSide)
      }.frame(width: geometry.size.width, height: geometry.size.height)
    }
  }
}
