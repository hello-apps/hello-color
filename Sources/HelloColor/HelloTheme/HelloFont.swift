import SwiftUI

public enum HelloFont: Codable {
  
  case rounded
  case normal
  case mono
  
  public func font(size: CGFloat, weight: Font.Weight) -> Font {
    switch self {
      case .rounded: return .system(size: size, weight: weight, design: .rounded)
      case .normal: return .system(size: size, weight: weight, design: .rounded)
      case .mono: return .system(size: size, weight: weight, design: .monospaced)
    }
  }
  
  public var title: Font {
    font(size: 24, weight: .semibold)
  }
  
  public var sectionTtile: Font {
    font(size: 16, weight: .bold)
  }
  
  public var controlLabel: Font {
    font(size: 12, weight: .semibold)
  }
}
