import SwiftUI
import SwiftUIConvenience

public enum HelloBackground: Equatable, Codable {
  
  case solid(HelloColor)
  case bordered(fill: HelloColor, border: HelloColor)
  case lightTranslucent
  case darkTranslucent
  case retro
  case pride
  
  public var color: HelloColor {
    switch self {
    case .solid(let color): return color
    case .bordered(let color, _): return color
    case .lightTranslucent: return .white
    case .darkTranslucent: return .black
    case .retro: return HelloColor.retroApple.lightPlastic
    case .pride: return HelloColor.pride.red
    }
  }
  
  @ViewBuilder
  public func view<ShapeT: InsettableShape>(for shape: ShapeT) -> some View {
    switch self {
    case .solid(.black):
      ZStack {
        shape.stroke(HelloColor.dark.swiftuiColor, lineWidth: 4)
        shape.fill(color.swiftuiColor)
      }
    case .lightTranslucent:
      ZStack {
        #if os(iOS)
        Blur(style: .systemUltraThinMaterialLight)
        #endif
        HelloColor.white.swiftuiColor.opacity(0.5)
      }.clipShape(shape)
    case .darkTranslucent:
      ZStack {
        #if os(iOS)
        Blur(style: .systemUltraThinMaterialDark)
        #endif
        HelloColor.black.swiftuiColor.opacity(0.5)
      }.clipShape(shape)
    case .retro: RetroAppleColorsVertical().clipShape(shape)
    case .pride: PrideColorsHorizontal().clipShape(shape)
    case .bordered(let fill, let border):
      ZStack {
        shape.fill(fill.swiftuiColor)
        shape.strokeBorder(border.swiftuiColor, lineWidth: 2)
      }
    default: shape.fill(color.swiftuiColor)
    }
  }
}
