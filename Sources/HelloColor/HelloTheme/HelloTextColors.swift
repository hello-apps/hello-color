import SwiftUI

public enum HelloTextColors: Equatable, Codable {
  
  case constant(HelloColor)
  case light
  case dark
  case white
  case black
  case dim
  case ketchup
  
  public var primary: Color {
    switch self {
    case .constant(let color): return color.swiftuiColor
    case .light: return HelloColor.light.swiftuiColor
    case .dark: return HelloColor.dark.swiftuiColor
    case .white: return HelloColor.white.swiftuiColor
    case .black: return HelloColor.black.swiftuiColor
    case .dim: return HelloColor.veryDimWhite.swiftuiColor
    case .ketchup: return HelloColor.ketchup.yellow.swiftuiColor
    }
  }
  
  public var secondary: Color {
    switch self {
    case .constant(let color): return color.swiftuiColor
    case .light, .ketchup: return HelloColor.light.swiftuiColor.opacity(0.85)
    case .dark: return HelloColor.veryDimWhite.swiftuiColor
    case .white, .black, .dim: return primary
    }
  }
  
  public var tertiary: Color {
    switch self {
    case .constant(let color): return color.swiftuiColor
    case .light, .ketchup: return HelloColor.light.swiftuiColor.opacity(0.65)
    case .dark: return HelloColor.veryDimWhite.swiftuiColor
    case .white, .black, .dim: return primary
    }
  }
  
  public var invert: Color {
    switch self {
    case .constant(let color): return color.swiftuiColor
    case .light, .ketchup: return HelloColor.dark.swiftuiColor
    case .dark: return HelloColor.light.swiftuiColor
    case .white: return HelloColor.black.swiftuiColor
    case .black: return HelloColor.white.swiftuiColor
    case .dim: return HelloColor.darkGrey.swiftuiColor
    }
  }
}
