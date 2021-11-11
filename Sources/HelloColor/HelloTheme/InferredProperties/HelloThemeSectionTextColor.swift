import SwiftUI

public extension HelloTheme {
  var sectionTextColors: HelloTextColors {
    if let overrideTextColors = overrideLayer1TextColors {
      return overrideTextColors
    }
    
    return defaultTextColors(for: overrideLayer1Background ?? layer1Background,
                                layeredOn: color(for: .background))
  }
  
  var layer2TextColors: HelloTextColors {
    if let overrideTextColors = overrideLayer2TextColors {
      return overrideTextColors
    }
    switch overrideLayer2Background ?? layer2Background {
    default: return defaultTextColors(for: overrideLayer2Background ?? layer2Background,
                                         layeredOn: color(for: .layer1))
    }
  }
  
  func defaultTextColors(for layer: HelloSectionBackground,
                         layeredOn underLayer: HelloColor) -> HelloTextColors {
    layer.color(layeredOn: underLayer).isDark ? .light : .dark
  }
}
