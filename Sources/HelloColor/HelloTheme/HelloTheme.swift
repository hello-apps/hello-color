import SwiftUI
import SwiftUIConvenience

public struct HelloTheme: Equatable {
  public var background: HelloBackground
  
  public var overrideBackgroundTextColors: HelloTextColors?
  public var overrideLayer1TextColors: HelloTextColors?
  public var overrideLayer2TextColors: HelloTextColors?
  public var overrideFloatingTextColors: HelloTextColors?
  public var overrideLayer1Background: HelloSectionBackground?
  public var overrideLayer2Background: HelloSectionBackground?
  public var overrideFloatingBackground: HelloSectionBackground?
  
  public var overrideAccentColor: HelloColor?
  
  public var font: HelloFont = .rounded
  
  public var isDark: Bool {
    switch background {
    case .solid(let color),
        .bordered(let color, _): return color.isDark
    case
        .lightTranslucent:
      return false
    case
        .darkTranslucent,
        .retro,
        .pride:
      return true
    }
  }
  
  public var isDim: Bool {
    switch background {
    case .solid(let color),
        .bordered(let color, _):
      return color.isDim && textColors(for: .background) == .dim
    default: return false
    }
  }
  
  public var accentColor: HelloColor {
    overrideAccentColor ?? textColors(for: .background).primary.helloColor
  }
  
  public func accentColor(on layer: Layer) -> Color {
    switch layer {
    case .background:
      guard !background.color.isSimilar(to: accentColor)
      else { return textColors(for: .background).primary }
    case .layer1:
      guard !layer1Background.color(layeredOn: background.color).isSimilar(to: accentColor)
      else { return textColors(for: .layer1).primary }
    case .layer2:
      guard !layer2Background.color(layeredOn: color(for: .layer1)).isSimilar(to: accentColor)
      else { return textColors(for: .layer2).primary }
    case .floating:
      guard !floatingBackground.color().isSimilar(to: accentColor)
      else { return textColors(for: .floating).primary }
    case .accent: return accentColor.readableOverlayColor.swiftuiColor
    }
    return accentColor.swiftuiColor
  }
  
  public func linkColor(on layer: Layer) -> HelloColor {
    let backgroundColor = color(for: layer)
    let textColor = textColors(for: layer).primary.helloColor
    let accentColor = accentColor(on: layer).helloColor
    
    if isDim {
      return .skyBlue.withFakeAlpha(0.5, background: .black)
    } else if !accentColor.isSimilar(to: textColor) {
      return accentColor
    } else if backgroundColor.isEssentiallyGreyscale {
      if backgroundColor.isDark {
        return .skyBlue
      } else {
        return .skyBlue
      }
    } else {
      if textColor.isEssentiallyGreyscale {
        if textColor.isDark {
          return .skyBlue.darken()
        } else {
          return .skyBlue.lighten()
        }
      } else {
        if backgroundColor.isDark {
          return .light
        } else {
          return .dark
        }
      }
    }
  }
  
  public func errorColor(on layer: Layer) -> HelloColor {
    let backgroundColor = color(for: layer)
    let textColor = textColors(for: layer).primary.helloColor
    
    if backgroundColor.isEssentiallyGreyscale {
      if backgroundColor.isDark {
        return .fadedRed
      } else {
        return .fadedRed
      }
    } else {
      if backgroundColor.isDark {
        return .light
      } else {
        return .dark
      }
    }
  }
  
  public var layer1Background: HelloSectionBackground {
    if let layer1Background = overrideLayer1Background {
      return layer1Background
    }
    
    switch background {
    case .retro: return .darkBlur
    case .pride: return .darkBlur
    case .solid(.retroApple.lightPlastic): return .solid(.white)
    case .darkTranslucent: return .slightLighten
    case .solid(.black): return .slightLighten
    default: return .slightDarken
    }
  }
  
  public var layer2Background: HelloSectionBackground {
    if let layer2Background = overrideLayer2Background {
      return layer2Background
    }
    
    switch background {
    case .darkTranslucent: return .slightLighten
    case .solid(.black): return .slightLighten
    default: return .slightDarken
    }
  }
  
  public enum Layer {
    case background
    case layer1
    case layer2
    case floating
    case accent
  }
  
  public func color(for layer: Layer) -> HelloColor {
    switch layer {
    case .background: return background.color
    case .layer1: return layer1Background.color(layeredOn: background.color)
    case .layer2: return layer2Background.color(layeredOn: color(for: .layer1))
    case .floating: return floatingBackground.color()
    case .accent: return accentColor
    }
  }
  
  public func textColors(for layer: Layer) -> HelloTextColors {
    switch layer {
    case .background: return backgroundTextColors
    case .layer1: return sectionTextColors
    case .layer2: return layer2TextColors
    case .floating: return overrideFloatingTextColors ?? backgroundTextColors
    case .accent: return isDim ? .black : accentColor.isDark ? .light : .dark
    }
  }
  
  public func readableTextColors(on color: HelloColor) -> HelloTextColors {
    isDim
      ? color.brightness < 0.14 ? .dim : .black
      : color.isDark ? .light : .dark
  }
  
  @ViewBuilder
  public func backgroundView<ShapeT: InsettableShape>(layer: Layer, shape: ShapeT) -> some View {
    switch layer {
    case .background: background.view(for: shape)
    case .layer1: layer1Background.view(for: shape, layeredOn: background.color)
    case .layer2: layer2Background.view(for: shape, layeredOn: color(for: .layer1))
    case .floating:
      ZStack {
        #if os(iOS)
        Blur(style: layer1Background.color(layeredOn: background.color).isDark ? .systemUltraThinMaterialDark : .systemUltraThinMaterialLight)
          .clipShape(shape)
        #endif
        shape.fill(background.color.swiftuiColor.opacity(0.8))
      }
    case .accent: shape.fill(accentColor.swiftuiColor)
    }
  }
  
  public var floatingBackground: HelloSectionBackground {
    if let floatingBackground = overrideFloatingBackground {
      return floatingBackground
    }
    
    switch background {
    case .solid(let color),
        .bordered(let color, _): return color.isDark ? .darkBlur : .lightBlur
    case .lightTranslucent: return .lightBlur
    case .darkTranslucent: return .darkBlur
    case .retro: return .darkBlur
    case .pride: return .darkBlur
    }
  }
  
  public init(
    background: HelloBackground,
    backgroundTextColors: HelloTextColors? = nil,
    layer1TextColors: HelloTextColors? = nil,
    layer2TextColors: HelloTextColors? = nil,
    floatingTextColors: HelloTextColors? = nil,
    layer1Background: HelloSectionBackground? = nil,
    layer2Background: HelloSectionBackground? = nil,
    floatingBackground: HelloSectionBackground? = nil,
    accentColor: HelloColor? = nil
  ) {
    self.background = background
    overrideBackgroundTextColors = backgroundTextColors
    overrideLayer1TextColors = layer1TextColors
    overrideLayer2TextColors = layer2TextColors
    overrideFloatingTextColors = floatingTextColors
    overrideLayer1Background = layer1Background
    overrideLayer2Background = layer2Background
    overrideFloatingBackground = floatingBackground
    overrideAccentColor = accentColor
  }
}

private struct HelloThemeEnvironmentKey: EnvironmentKey {
  static let defaultValue: HelloTheme = .panda
}

public extension EnvironmentValues {
  var helloTheme: HelloTheme {
    get { self[HelloThemeEnvironmentKey.self] }
    set { self[HelloThemeEnvironmentKey.self] = newValue }
  }
}

public extension HelloTheme {
  
  static var panda: HelloTheme {
    HelloTheme(background: .solid(.dark),
               layer1Background: .solid(.light),
               layer2Background: .solid(.dark),
               accentColor: .light)
  }
  
  static var mario: HelloTheme {
    HelloTheme(background: .solid(.skyBlue),
               layer1Background: .solid(.mario.red),
               layer2Background: .solid(.mario.blue),
               floatingBackground: .solid(.mario.red),
               accentColor: .mario.yellow)
  }
  
  static var darkTranslucent: HelloTheme {
    HelloTheme(background: .darkTranslucent,
               layer1Background: .slightLighten,
               layer2Background: .slightDarken,
               floatingBackground: .darkBlur)
  }
  
  static var lightTranslucent: HelloTheme {
    HelloTheme(background: .lightTranslucent,
               layer1Background: .slightLighten,
               layer2Background: .slightDarken,
               floatingBackground: .lightBlur)
  }
  
  static var white: HelloTheme {
    HelloTheme(background: .solid(.white),
               layer1Background: .bordered(fill: .white, border: .light),
               layer2Background: .bordered(fill: .white, border: .light),
               floatingBackground: .lightBlur)
  }
  
  static var light: HelloTheme {
    HelloTheme(background: .solid(.offWhite),
               layer1Background: .solid(.white),
               layer2Background: .solid(.light),
               floatingBackground: .lightBlur)
  }
  
  static var dark: HelloTheme {
    HelloTheme(background: .solid(.darker),
               layer1Background: .solid(.dark),
               layer2Background: .slightLighten,
               floatingBackground: .darkBlur)
  }
  
  static var black: HelloTheme {
    HelloTheme(background: .solid(.black),
               layer1Background: .solid(.darker),
               layer2Background: .solid(.dark))
  }
  
  static var ketchup: HelloTheme {
    HelloTheme(background: .solid(.ketchup.red),
               backgroundTextColors: .constant(.ketchup.yellow),
               layer1TextColors: .constant(.dark),
               layer1Background: .solid(.ketchup.orange),
               layer2Background: .solid(.ketchup.red),
               accentColor: .ketchup.yellow)
  }
  
  static var monkey: HelloTheme {
    HelloTheme(background: .solid(.monkey.lightOrange),
               backgroundTextColors: .constant(.monkey.white),
               layer1TextColors: .constant(.monkey.darkOrange),
               layer1Background: .solid(.monkey.white),
               layer2Background: .solid(.monkey.darkOrange),
               accentColor: .monkey.white)
  }
  
  static var blackDim: HelloTheme {
    HelloTheme(background: .solid(.black),
               backgroundTextColors: .dim,
               layer1TextColors: .dim,
               layer2TextColors: .dim,
               layer1Background: .bordered(fill: .black, border: .darkerGrey),
               layer2Background: .bordered(fill: .black, border: .darkerGrey),
               floatingBackground: .veryDarkBlur)
  }
}
