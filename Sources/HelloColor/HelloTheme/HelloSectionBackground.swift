import SwiftUI
import SwiftUIConvenience

public enum HelloSectionBackground: Equatable, Codable {
  
  case solid(HelloColor)
  case bordered(fill: HelloColor, border: HelloColor)
  case lightBlur
  case darkBlur
  case veryDarkBlur
  case slightDarken
  case moderateDarken
  case slightLighten
  case moderateLighten
  
  public func color(layeredOn underColor: HelloColor = .transparent) -> HelloColor {
    switch self {
    case .solid(let color): return color
    case .bordered(let color, _): return color
    case .lightBlur: return .white
    case .darkBlur: return .black
    case .veryDarkBlur: return .black
    case .slightDarken: return .black.withFakeAlpha(0.1, background: underColor)
    case .moderateDarken: return .black.withFakeAlpha(0.25, background: underColor)
    case .slightLighten: return .white.withFakeAlpha(0.1, background: underColor)
    case .moderateLighten: return .white.withFakeAlpha(0.16, background: underColor)
    }
  }
  
  public var destructiveColor: Color {
    switch self {
    default: return .red
    }
  }
  
  @ViewBuilder
  public func view<ShapeT: InsettableShape>(for shape: ShapeT, layeredOn underColor: HelloColor) -> some View {
    switch self {
    case .lightBlur:
      ZStack {
        #if os(iOS)
        Blur(style: .systemUltraThinMaterialLight)
        #elseif os(macOS)
        Blur()
        #endif
      }.clipShape(shape)
    case .darkBlur:
      ZStack {
        #if os(iOS)
        Blur(style: .systemUltraThinMaterialDark)
        #elseif os(macOS)
        Blur()
        #endif
      }.clipShape(shape)
    case .veryDarkBlur:
      ZStack {
        #if os(iOS)
        Blur(style: .systemUltraThinMaterialDark)
        #elseif os(macOS)
        Blur()
        #endif
        Color.black.opacity(0.75)
      }.clipShape(shape)
    case .bordered(let fill, let border):
      ZStack {
        shape.fill(fill.swiftuiColor)
        shape.strokeBorder(border.swiftuiColor, lineWidth: 2)
      }
    default:
      ZStack {
        shape.fill(color(layeredOn: underColor).swiftuiColor)
        shape.strokeBorder(.black.opacity(0.1), lineWidth: 1)
      }
    }
  }
}
