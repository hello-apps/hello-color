import SwiftUI

public extension HelloTheme {
  
  var confettiColors: [Color] {
    switch background {
    case
        .lightTranslucent,
        .darkTranslucent,
        .retro,
        .pride:
      return [
        backgroundTextColors.primary,
        HelloColor.retroApple.red.swiftuiColor,
        HelloColor.retroApple.green.swiftuiColor,
        HelloColor.retroApple.yellow.swiftuiColor,
        HelloColor.retroApple.orange.swiftuiColor,
        HelloColor.retroApple.blue.swiftuiColor
      ]
    case .solid(let color),
        .bordered(let color, _):
      if color == .black && backgroundTextColors == .dim {
        return [Color(red: 0.6, green: 0.6, blue: 0.6)]
      } else if color.isGreyscale {
        return [
          backgroundTextColors.primary,
          HelloColor.retroApple.red.swiftuiColor,
          HelloColor.retroApple.green.swiftuiColor,
          HelloColor.retroApple.yellow.swiftuiColor,
          HelloColor.retroApple.orange.swiftuiColor,
          HelloColor.retroApple.blue.swiftuiColor
        ]
      } else {
        return color.isDark
          ? [Color(red: 0.6, green: 0.6, blue: 0.6)]
          : [Color(red: 1.0, green: 1, blue: 1)]
      }
    }
  }
}
