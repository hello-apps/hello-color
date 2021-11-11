import SwiftUI

public extension HelloTheme {
  var backgroundTextColors: HelloTextColors {
    if let backgroundTextColors = overrideBackgroundTextColors {
      return backgroundTextColors
    }
    
    switch background {
    case .solid(let color),
        .bordered(let color, _): return color.isDark ? .light : .dark
    case .lightTranslucent: return .dark
    case .darkTranslucent: return .light
    case .retro: return .white
    case .pride: return .white
    }
  }
}
