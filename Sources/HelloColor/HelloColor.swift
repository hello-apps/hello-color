import SwiftUI

#if canImport(UIKit)
public typealias NativeColor = UIColor
#elseif canImport(AppKit)
public typealias NativeColor = NSColor
#endif

public struct  HelloColor: Codable, Equatable, Hashable {
  public var r: Double
  public var g: Double
  public var b: Double
  public var a: Double
  
  public init(r: Double, g: Double, b: Double, a: Double = 1) {
    self.r = min(1, max(0, r))
    self.g = min(1, max(0, g))
    self.b = min(1, max(0, b))
    self.a = min(1, max(0, a))
  }
  
  public var nativeColor: NativeColor {
    NativeColor(displayP3Red: CGFloat(r),
                green: CGFloat(g),
                blue: CGFloat(b),
                alpha: CGFloat(a))
  }
  
  public var swiftuiColor: Color {
    Color(.displayP3, red: r, green: g, blue: b, opacity: a)
  }
  
  public func withFakeAlpha(_ alpha: Double, background: HelloColor) -> HelloColor {
    HelloColor(r: r * alpha + background.r * (1 - alpha),
              g: g * alpha + background.g * (1 - alpha),
              b: b * alpha + background.b * (1 - alpha),
              a: a)
  }
}

public extension HelloColor {
  static var white: HelloColor { HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 1) }
  static var black: HelloColor { HelloColor(r: 0.0, g: 0.0, b: 0.0, a: 1) }
  
  static var textPrimaryLight = HelloColor(r: 0.9, g: 0.9, b: 0.9, a: 1)
  static var textPrimaryDark = HelloColor(r: 0.1, g: 0.1, b: 0.1, a: 1)
  
  static var textSecondaryLight = HelloColor(r: 0.75, g: 0.75, b: 0.75, a: 1)
  static var textSecondaryDark = HelloColor(r: 0.2, g: 0.2, b: 0.2, a: 1)
  
  static var textTertiaryLight = HelloColor(r: 0.6, g: 0.6, b: 0.6, a: 1)
  static var textTertiaryDark = HelloColor(r: 0.35, g: 0.35, b: 0.35, a: 1)
  
  static var monkeyOrange: HelloColor { HelloColor(r: 0.8, g: 0.4, b: 0.2) }
  
  static var pink: HelloColor { HelloColor(r: 0.6, g: 0.4, b: 0.4) }
  static var fullBlue: HelloColor { HelloColor(r: 0, g: 0, b: 1) }
  static var fullGreen: HelloColor { HelloColor(r: 0, g: 1, b: 0) }
  static var darkGreen: HelloColor { HelloColor(r: 0.2, g: 0.5, b: 0.15) }
  static var darkBlue: HelloColor { HelloColor(r: 0, g: 0, b: 0.5) }
  static var fullOrange: HelloColor { HelloColor(r: 1, g: 0.5, b: 0) }
  static var skyBlue: HelloColor { HelloColor(r: 0.41, g: 0.57, b: 0.96) }
  static var twitter: HelloColor { HelloColor(r: 0.12, g: 0.63, b: 0.96) }
  
  static var solitaireAccent: HelloColor { HelloColor(r: 0.25, g: 0.7, b: 0.25) }
  static var snapchat: HelloColor { HelloColor(r: 1, g: 0.99, b: 0.02) }
  
  static var dark: HelloColor { HelloColor(r: 0.14, g: 0.14, b: 0.14) }
  static var darker: HelloColor { HelloColor(r: 0.1, g: 0.1, b: 0.1) }
  static var transparent: HelloColor { HelloColor(r: 0, g: 0, b: 0, a: 0) }
  static var light: HelloColor { HelloColor(r: 0.9, g: 0.9, b: 0.9) }
  static var oldWhite: HelloColor { HelloColor(r: 0.95, g: 0.95, b: 0.91) }
  static var offWhite: HelloColor { HelloColor(r: 0.95, g: 0.95, b: 0.95) }
  
  static var dimWhite: HelloColor { HelloColor(r: 0.5, g: 0.5, b: 0.5) }
  static var veryDimWhite: HelloColor { HelloColor(r: 0.35, g: 0.35, b: 0.35) }
  static var veryDimRed: HelloColor { HelloColor(r: 0.5, g: 0.1, b: 0.1) }
  static var dimRed: HelloColor { HelloColor(r: 0.6, g: 0.1, b: 0.1) }
  
  static var fadedRed: HelloColor { HelloColor(r: 0.9, g: 0, b: 0) }
  static var fullRed: HelloColor { HelloColor(r: 1.0, g: 0, b: 0) }
  
  static var darkGrey: HelloColor { HelloColor(r: 0.32, g: 0.32, b: 0.32) }
  static var darkerGrey: HelloColor { HelloColor(r: 0.26, g: 0.26, b: 0.26) }
  
  static var neonGreen: HelloColor { HelloColor(r: 0.1, g: 0.8, b: 0.1) }
  
  enum simpsons {}
  enum creamsicle {}
  enum lego {}
  enum ketchup {}
  enum bluePalette {}
  enum forest {}
  enum mario {}
  enum pride {}
  enum retroApple {}
  enum retroGrey {}
  enum google {}
  enum monkey {}
  
  static var options: [HelloColor] {
    [
      .white, .light, .dimWhite, .veryDimWhite,
      .dark, .black, .veryDimRed, .dimRed,
      .retroApple.red, .ketchup.red, .fadedRed, .fullRed,
      .mario.red, .retroApple.purple, .retroApple.blue, .mario.blue, .retroApple.green, .neonGreen,
      .ketchup.orange, .retroApple.orange, .retroApple.yellow, .ketchup.yellow, .mario.yellow
      
    ]
  }
}

public extension HelloColor.google {
  static var red: HelloColor { HelloColor(r: 0.91, g: 0.27, b: 0.21) }
  static var green: HelloColor { HelloColor(r: 0.22, g: 0.68, b: 0.32) }
  static var blue: HelloColor { HelloColor(r: 0.26, g: 0.53, b: 0.96) }
  static var yellow: HelloColor { HelloColor(r: 0.98, g: 0.74, b: 0) }
}

public extension HelloColor.mario {
  static var questionBlock: HelloColor { HelloColor(r: 0.95, g: 0.65, b: 0.4) }
  static var questionBlockFill: HelloColor { HelloColor(r: 0.84, g: 0.40, b: 0.2) }
  static var red: HelloColor { HelloColor(r: 0.8, g: 0.2, b: 0.13) }
  static var blue: HelloColor { HelloColor(r: 0.17, g: 0.40, b: 0.88) }
  static var yellow: HelloColor { HelloColor(r: 0.9, g: 0.9, b: 0) }
}

public extension HelloColor.retroGrey {
  static var light: HelloColor { HelloColor(r: 1, g: 1, b: 1) }
  static var medium: HelloColor { HelloColor(r: 0.74, g: 0.74, b: 0.74) }
  static var dark: HelloColor { HelloColor(r: 0.48, g: 0.48, b: 0.48) }
}

public extension HelloColor.bluePalette {
  static var light: HelloColor { HelloColor(r: 0.5, g: 0.8, b: 1) }
  static var medium: HelloColor { HelloColor(r: 0.21, g: 0.47, b: 0.96) }
  static var dark: HelloColor { HelloColor(r: 0.09, g: 0.22, b: 0.46) }
}

public extension HelloColor.pride {
  static var red: HelloColor { HelloColor(r: 0.92, g: 0.3, b: 0.24) }
  static var orange: HelloColor { HelloColor(r: 0.95, g: 0.6, b: 0.22) }
  static var yellow: HelloColor { HelloColor(r: 0.97, g: 0.8, b: 0.27) }
  static var green: HelloColor { HelloColor(r: 0.47, g: 0.84, b: 0.45) }
  static var blue: HelloColor { HelloColor(r: 0.21, g: 0.47, b: 0.96) }
  static var violet: HelloColor { HelloColor(r: 0.44, g: 0.2, b: 0.96) }
  static var pink: HelloColor { HelloColor(r: 0.74, g: 0.2, b: 1, a: 1) }
  
  static var all: [HelloColor] {
    [.pride.red, .pride.orange, .pride.yellow,
     .pride.green, .pride.blue, .pride.violet]
  }
}

public extension HelloColor.retroApple {
  static var green: HelloColor { HelloColor(r: 0.47, g: 0.72, b: 0.33, a: 1) }
  static var yellow: HelloColor { HelloColor(r: 0.92, g: 0.71, b: 0.28, a: 1) }
  static var orange: HelloColor { HelloColor(r: 0.89, g: 0.53, b: 0.23, a: 1) }
  static var red: HelloColor { HelloColor(r: 0.81, g: 0.29, b: 0.27, a: 1) }
  static var purple: HelloColor { HelloColor(r: 0.53, g: 0.25, b: 0.56, a: 1) }
  static var blue: HelloColor { HelloColor(r: 0.27, g: 0.61, b: 0.84, a: 1) }
  
  static var lightPlastic: HelloColor { HelloColor(r: 0.86, g: 0.86, b: 0.82) }
  
  static var all: [HelloColor] {
    [.retroApple.green, .retroApple.yellow, .retroApple.orange,
     .retroApple.red, .retroApple.purple, .retroApple.blue]
  }
}

public extension HelloColor.ketchup {
  static var red: HelloColor { HelloColor(r: 0.77, g: 0, b: 0) }
  static var yellow: HelloColor { HelloColor(r: 0.96, g: 0.7, b: 0) }
  static var orange: HelloColor { HelloColor(r: 0.9, g: 0.57, b: 0.05) }
}

public extension HelloColor.simpsons {
  static var skin: HelloColor { HelloColor(r: 0.99, g: 0.92, b: 0.31) }
  static var eyes: HelloColor { HelloColor.white }
  
  static var margeDress: HelloColor { HelloColor(r: 0.47, g: 0.84, b: 0.45) }
  static var margeHair: HelloColor { HelloColor(r: 0.21, g: 0.47, b: 0.96) }
}

public extension HelloColor.creamsicle {
  static var orange: HelloColor { HelloColor(r: 0.98, g: 0.65, b: 0.23) }
  static var vanilla: HelloColor { HelloColor(r: 1, g: 1, b: 0.97) }
}

public extension HelloColor.lego {
  static var red: HelloColor { HelloColor(r: 0.65, g: 0.13, b: 0.09) }
  static var blue: HelloColor { HelloColor(r: 0.19, g: 0.35, b: 0.64) }
  static var yellow: HelloColor { HelloColor(r: 0.95, g: 0.79, b: 0.27) }
  static var orange: HelloColor { HelloColor(r: 0.79, g: 0.49, b: 0.22) }
  static var green: HelloColor { HelloColor(r: 0.43, g: 0.66, b: 0.31) }
}

public extension HelloColor.forest {
  static var green1: HelloColor { HelloColor(r: 0.16, g: 0.31, b: 0.24) }
  static var green2: HelloColor { HelloColor(r: 0.21, g: 0.38, b: 0.24) }
  static var green3: HelloColor { HelloColor(r: 0.35, g: 0.55, b: 0.29) }
  static var green4: HelloColor { HelloColor(r: 0.58, g: 0.75, b: 0.42) }
}

public extension HelloColor.mario {
  static var brick: HelloColor { HelloColor(r: 0.57, g: 0.31, b: 0.13) }
}

public extension HelloColor.monkey {
  static var lightOrange: HelloColor { HelloColor(r: 0.71, g: 0.46, b: 0.35) }
  static var darkOrange: HelloColor { HelloColor(r: 0.60, g: 0.36, b: 0.27) }
  static var white: HelloColor { HelloColor(r: 0.95, g: 0.93, b: 0.93) }
}

public extension Color {
  static let selfTextPrimaryDark: Color = HelloColor.textPrimaryDark.swiftuiColor
  static let selfTextSecondaryDark: Color = HelloColor.textSecondaryDark.swiftuiColor
  static let selfTextTertiaryDark: Color = HelloColor.textTertiaryDark.swiftuiColor
  static let selfTextInvertDark: Color = Color(red: 0.9, green: 0.9, blue: 0.9)
}

public extension HelloColor {
  func isSimilar(to otherColor: HelloColor) -> Bool {
    let diff = abs(r - otherColor.r) + abs(g - otherColor.g) + abs(b - otherColor.b)
    return diff / 3 < 0.1
  }
  
  var brightness: Double {
    r * 0.225 + g * 0.7 + b * 0.075
  }
  
  var isDark: Bool {
    brightness < 0.7
  }
  
  var isDim: Bool {
    brightness < 0.4
  }
  
  var isGreyscale: Bool {
    r == b && b == g
  }
  
  var isEssentiallyGreyscale: Bool {
    abs(r - b) < 0.1 && abs(b - g) < 0.1
  }
  
  var readableOverlayColor: HelloColor {
    isDark ? .light : .dark
  }
  
  func with(brightness: Double) -> HelloColor {
    HelloColor(r: brightness * r, g: brightness * g, b: brightness * b, a: a)
  }
  
  func lighten() -> HelloColor {
    with(brightness: 1.4)
  }
  
  func darken() -> HelloColor {
    with(brightness: 0.65)
  }
}

extension HelloColor: Identifiable {
  public var id: String { String(describing: self) }
}

public extension Color {
  var helloColor: HelloColor {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var o: CGFloat = 0
    
    #if os(iOS)
    guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
      // You can handle the failure here as you want
      return .transparent
    }
    #else
    NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o)
    #endif
    
    return HelloColor(r: r, g: g, b: b, a: o)
  }
}
