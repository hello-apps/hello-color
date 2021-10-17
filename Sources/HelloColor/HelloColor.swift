import SwiftUI

#if canImport(UIKit)
public typealias NativeColor = UIColor
#elseif canImport(AppKit)
public typealias NativeColor = NSColor
#endif

public struct DynamicHelloColor: Codable, Equatable, Hashable {
  var light: HelloColor
  var dark: HelloColor
  
  public init(light: HelloColor, dark: HelloColor) {
    self.light = light
    self.dark = dark
  }
  
  public var nativeColor: NativeColor {
#if canImport(AppKit)
    return NativeColor(name: nil) {
      [.darkAqua, .vibrantDark].contains($0.bestMatch(from: [.aqua, .darkAqua, .vibrantDark, .vibrantLight]) ?? .aqua)
      ? dark.nativeColor : light.nativeColor
    }
#elseif canImport(WatchKit)
    return dark.nativeColor
#elseif canImport(UIKit)
    return NativeColor {
      $0.userInterfaceStyle == .dark ? dark.nativeColor : light.nativeColor
    }
#endif
  }
  
  public var swiftuiColor: Color {
    Color(nativeColor)
  }
  
  public func withFakeAlpha(_ alpha: Double) -> DynamicHelloColor {
    DynamicHelloColor(light: light.withFakeAlpha(alpha, background: .white),
                     dark: dark.withFakeAlpha(alpha, background: .black))
  }
}

public struct HelloColor: Codable, Equatable, Hashable {
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
    Color(.displayP3, red: r, green: g, blue: b)
  }
  
  public func withFakeAlpha(_ alpha: Double, background: HelloColor) -> HelloColor {
    HelloColor(r: r * alpha + background.r * (1 - alpha),
              g: g * alpha + background.g * (1 - alpha),
              b: b * alpha + background.b * (1 - alpha),
              a: 1)
  }
}

public extension HelloColor {
  static var white = HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 1)
  static var black = HelloColor(r: 0.0, g: 0.0, b: 0.0, a: 1)
  
  static var success = DynamicHelloColor(light: HelloColor(r: 0.2, g: 0.9, b: 0.2, a: 1),
                                        dark: HelloColor(r: 0.4, g: 0.8, b: 0.4, a: 1))
  
  static var error = DynamicHelloColor(light: HelloColor(r: 1, g: 0.2, b: 0.2, a: 1),
                                      dark: HelloColor(r: 0.8, g: 0.1, b: 0.1, a: 1))
  
  static var floatingCell = DynamicHelloColor(light: HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 1),
                                             dark: HelloColor(r: 0.08, g: 0.08, b: 0.08, a: 1))
  
  static var layer1 = DynamicHelloColor(light: HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 1),
                                       dark: HelloColor(r: 0.0, g: 0.0, b: 0.0, a: 1))
  
  static var layer2 = DynamicHelloColor(light: HelloColor(r: 0.96, g: 0.96, b: 0.96, a: 1),
                                       dark: HelloColor(r: 0.1, g: 0.1, b: 0.1, a: 1))
  
  static var layer3 = DynamicHelloColor(light: HelloColor(r: 0.96, g: 0.96, b: 0.96, a: 1),
                                       dark: HelloColor(r: 0.1, g: 0.1, b: 0.1, a: 1))
  
  //  static var layer3 = DynamicHelloColor(light: HelloColor(r: 0.96, g: 0.96, b: 0.96, a: 1),
  //                                       dark: HelloColor(r: 0.14, g: 0.14, b: 0.14, a: 1))
  
  static var layer4 = DynamicHelloColor(light: HelloColor(r: 0.825, g: 0.825, b: 0.825, a: 1),
                                       dark: HelloColor(r: 0.25, g: 0.25, b: 0.25, a: 1))
  
  static var floatingCellFaded = DynamicHelloColor(light: HelloColor(r: 0.975, g: 0.975, b: 0.975, a: 1),
                                                  dark: HelloColor(r: 0.15, g: 0.15, b: 0.15, a: 1))
  
  static var floatingCellFaded2 = DynamicHelloColor(light: HelloColor(r: 0.95, g: 0.95, b: 0.95, a: 1),
                                                   dark: HelloColor(r: 0.17, g: 0.17, b: 0.17, a: 1))
  
  static var textPrimaryLight = HelloColor(r: 0.9, g: 0.9, b: 0.9, a: 1)
  static var textPrimaryDark = HelloColor(r: 0.1, g: 0.1, b: 0.1, a: 1)
  
  static var textSecondaryLight = HelloColor(r: 0.75, g: 0.75, b: 0.75, a: 1)
  static var textSecondaryDark = HelloColor(r: 0.2, g: 0.2, b: 0.2, a: 1)
  
  static var textTertiaryLight = HelloColor(r: 0.6, g: 0.6, b: 0.6, a: 1)
  static var textTertiaryDark = HelloColor(r: 0.35, g: 0.35, b: 0.35, a: 1)
  
  
  static var textPrimary = DynamicHelloColor(light: .textPrimaryDark,
                                            dark: .textPrimaryLight)
  
  static var textSecondary = DynamicHelloColor(light: .textSecondaryDark,
                                              dark: .textSecondaryLight)
  
  static var textTertiary = DynamicHelloColor(light: .textTertiaryDark,
                                             dark: .textTertiaryLight)
  
  
  
  // Themes
  
  // Regular
  static var regularTranslucent = DynamicHelloColor(light: HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 0.4),
                                                   dark: HelloColor(r: 0.0, g: 0.0, b: 0.0, a: 0.4))
  
  // Stealth
  static var stealthTranslucent = DynamicHelloColor(light: HelloColor(r: 1.0, g: 1.0, b: 1.0, a: 0.8),
                                                   dark: HelloColor(r: 0.0, g: 0.0, b: 0.0, a: 0.8))
  
  // Red
  static var redAccent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.2, b: 0.2, a: 1),
                                          dark: HelloColor(r: 1, g: 0.1, b: 0.1, a: 1))
  static var redTranslucent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.4, b: 0.4, a: 0.6),
                                               dark: HelloColor(r: 0.8, g: 0, b: 0, a: 0.4))
  
  // Blue
  static var blue = DynamicHelloColor(light: HelloColor(r: 0.2, g: 0.2, b: 1, a: 1),
                                     dark: HelloColor(r: 0.1, g: 0.1, b: 0.8, a: 1))
  static var blueTranslucent = DynamicHelloColor(light: HelloColor(r: 0.2, g: 0.2, b: 1, a: 0.4),
                                                dark: HelloColor(r: 0.1, g: 0.1, b: 0.8, a: 0.4))
  
  // Yellow
  static var yellowAccent = DynamicHelloColor(light: HelloColor(r: 0.9, g: 0.9, b: 0.0, a: 1),
                                             dark: HelloColor(r: 0.8, g: 0.8, b: 0.1, a: 1))
  static var yellowTranslucent = DynamicHelloColor(light: HelloColor(r: 1, g: 1, b: 0.1, a: 0.4),
                                                  dark: HelloColor(r: 0.9, g: 0.9, b: 0, a: 0.4))
  
  // Orange
  static var orangeAccent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.5, b: 0, a: 1),
                                             dark: HelloColor(r: 1, g: 0.5, b: 0, a: 1))
  static var orangeTranslucent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.5, b: 0, a: 0.4),
                                                  dark: HelloColor(r: 1, g: 0.5, b: 0, a: 0.4))
  
  // Green
  static var greenAccent = DynamicHelloColor(light: HelloColor(r: 0.2, g: 1, b: 0.2, a: 1),
                                            dark: HelloColor(r: 0.1, g: 0.8, b: 0.1, a: 1))
  static var greenTranslucent = DynamicHelloColor(light: HelloColor(r: 0.2, g: 1, b: 0.2, a: 0.4),
                                                 dark: HelloColor(r: 0.1, g: 0.8, b: 0.1, a: 0.4))
  
  // Pink
  static var pinkAccent = DynamicHelloColor(light: HelloColor(r: 0.6, g: 0.4, b: 0.4, a: 1),
                                           dark: HelloColor(r: 0.8, g: 0.4, b: 0.4, a: 1))
  static var pinkTranslucent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.6, b: 0.6, a: 0.4),
                                                dark: HelloColor(r: 1, g: 0.5, b: 0.6, a: 0.4))
  
  // Purple
  static var purpleAccent = DynamicHelloColor(light: HelloColor(r: 0.6, g: 0.1, b: 0.6, a: 1),
                                             dark: HelloColor(r: 0.8, g: 0.1, b: 0.8, a: 1))
  static var purpleTranslucent = DynamicHelloColor(light: HelloColor(r: 1, g: 0.1, b: 1, a: 0.4),
                                                  dark: HelloColor(r: 0.8, g: 0.1, b: 0.8, a: 0.4))
  
  
  static var fullBlue = HelloColor(r: 0, g: 0, b: 1)
  static var fullGreen = HelloColor(r: 0, g: 1, b: 0)
  static var darkGreen = HelloColor(r: 0.2, g: 0.5, b: 0.15)
  static var darkBlue = HelloColor(r: 0, g: 0, b: 0.5)
  static var fullOrange = HelloColor(r: 1, g: 0.5, b: 0)
  static var skyBlue = HelloColor(r: 0.41, g: 0.57, b: 0.96)
  static var twitter = HelloColor(r: 0.12, g: 0.63, b: 0.96)
  
  static var solitaireAccent = HelloColor(r: 0.25, g: 0.7, b: 0.25)
  static var snapchat = HelloColor(r: 1, g: 0.99, b: 0.02)
  
  static var dark = HelloColor(r: 0.14, g: 0.14, b: 0.14)
  static var darker = HelloColor(r: 0.1, g: 0.1, b: 0.1)
  static var transparent = HelloColor(r: 0, g: 0, b: 0, a: 0)
  static var light = HelloColor(r: 0.9, g: 0.9, b: 0.9)
  
  static var dimWhite = HelloColor(r: 0.5, g: 0.5, b: 0.5)
  static var veryDimWhite = HelloColor(r: 0.35, g: 0.35, b: 0.35)
  static var veryDimRed = HelloColor(r: 0.5, g: 0.1, b: 0.1)
  static var dimRed = HelloColor(r: 0.6, g: 0.1, b: 0.1)
  
  static var fadedRed = HelloColor(r: 0.9, g: 0, b: 0)
  static var fullRed = HelloColor(r: 1.0, g: 0, b: 0)
  
  static var darkGrey = HelloColor(r: 0.32, g: 0.32, b: 0.32)
  static var darkerGrey = HelloColor(r: 0.26, g: 0.26, b: 0.26)
  
  static var neonGreen = HelloColor(r: 0.1, g: 0.8, b: 0.1)
  
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
}

public extension HelloColor.mario {
  static let questionBlock = HelloColor(r: 0.95, g: 0.65, b: 0.4)
  static let questionBlockFill = HelloColor(r: 0.84, g: 0.40, b: 0.2)
  static let red = HelloColor(r: 0.8, g: 0.2, b: 0.13)
  static let blue = HelloColor(r: 0.17, g: 0.40, b: 0.88)
  static let yellow = HelloColor(r: 0.9, g: 0.9, b: 0)
}

public extension HelloColor.retroGrey {
  static let light = HelloColor(r: 1, g: 1, b: 1)
  static let medium = HelloColor(r: 0.74, g: 0.74, b: 0.74)
  static let dark = HelloColor(r: 0.48, g: 0.48, b: 0.48)
}

public extension HelloColor.bluePalette {
  static let light = HelloColor(r: 0.5, g: 0.8, b: 1)
  static let medium = HelloColor(r: 0.21, g: 0.47, b: 0.96)
  static let dark = HelloColor(r: 0.09, g: 0.22, b: 0.46)
}

public extension HelloColor.pride {
  static let red = HelloColor(r: 0.92, g: 0.3, b: 0.24)
  static let orange = HelloColor(r: 0.95, g: 0.6, b: 0.22)
  static let yellow = HelloColor(r: 0.97, g: 0.8, b: 0.27)
  static let green = HelloColor(r: 0.47, g: 0.84, b: 0.45)
  static let blue = HelloColor(r: 0.21, g: 0.47, b: 0.96)
  static let violet = HelloColor(r: 0.44, g: 0.2, b: 0.96)
  static let pink = HelloColor(r: 0.74, g: 0.2, b: 1, a: 1)
}

public extension HelloColor.retroApple {
  static let green = HelloColor(r: 0.47, g: 0.72, b: 0.33, a: 1)
  static let yellow = HelloColor(r: 0.92, g: 0.71, b: 0.28, a: 1)
  static let orange = HelloColor(r: 0.89, g: 0.53, b: 0.23, a: 1)
  static let red = HelloColor(r: 0.81, g: 0.29, b: 0.27, a: 1)
  static let purple = HelloColor(r: 0.53, g: 0.25, b: 0.56, a: 1)
  static let blue = HelloColor(r: 0.27, g: 0.61, b: 0.84, a: 1)
  
  static let lightPlastic = HelloColor(r: 0.86, g: 0.86, b: 0.82)
  
  static var all: [HelloColor] {
    [.retroApple.green, .retroApple.yellow, .retroApple.orange,
     .retroApple.red, .retroApple.purple, .retroApple.blue]
  }
}


public extension Color {
  static let selfTextPrimary: Color = HelloColor.textPrimary.swiftuiColor
  static let selfTextSecondary: Color = HelloColor.textSecondary.swiftuiColor
  static let selfTextTertiary: Color = HelloColor.textTertiary.swiftuiColor
  static let selfTextInvert: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
  
  static let selfTextPrimaryLight: Color = HelloColor.textPrimaryLight.swiftuiColor
  static let selfTextSecondaryLight: Color = HelloColor.textSecondaryLight.swiftuiColor
  static let selfTextTertiaryLight: Color = HelloColor.textTertiaryLight.swiftuiColor
  static let selfTextInvertLight: Color = Color(red: 0.1, green: 0.1, blue: 0.1)
}

public extension HelloColor.ketchup {
  static var red = HelloColor(r: 0.77, g: 0, b: 0)
  static var yellow = HelloColor(r: 0.96, g: 0.7, b: 0)
  static var orange = HelloColor(r: 0.9, g: 0.57, b: 0.05)
}

public extension HelloColor.simpsons {
  static var skin = HelloColor(r: 0.99, g: 0.92, b: 0.31)
  static var eyes = HelloColor.white
  
  static var margeDress = HelloColor(r: 0.47, g: 0.84, b: 0.45)
  static var margeHair = HelloColor(r: 0.21, g: 0.47, b: 0.96)
}

public extension HelloColor.creamsicle {
  static var orange = HelloColor(r: 0.98, g: 0.65, b: 0.23)
  static var vanilla = HelloColor(r: 1, g: 1, b: 0.97)
}

public extension HelloColor.lego {
  static var red = HelloColor(r: 0.65, g: 0.13, b: 0.09)
  static var blue = HelloColor(r: 0.19, g: 0.35, b: 0.64)
  static var yellow = HelloColor(r: 0.95, g: 0.79, b: 0.27)
  static var orange = HelloColor(r: 0.79, g: 0.49, b: 0.22)
  static var green = HelloColor(r: 0.43, g: 0.66, b: 0.31)
}

public extension HelloColor.forest {
  static var green1 = HelloColor(r: 0.16, g: 0.31, b: 0.24)
  static var green2 = HelloColor(r: 0.21, g: 0.38, b: 0.24)
  static var green3 = HelloColor(r: 0.35, g: 0.55, b: 0.29)
  static var green4 = HelloColor(r: 0.58, g: 0.75, b: 0.42)
}

public extension HelloColor.mario {
  static var brick = HelloColor(r: 0.57, g: 0.31, b: 0.13)
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
    return brightness < 0.65
  }
  
  var isDim: Bool {
    brightness < 0.4
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
