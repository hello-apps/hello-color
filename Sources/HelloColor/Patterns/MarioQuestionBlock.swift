import SwiftUI

public struct QuestionBlockView: View {
  
  public init() {}
  
  public var body: some View {
    GeometryReader { geometry in
      ZStack {
        ZStack {
          Circle()
            .fill(HelloColor.mario.questionBlockFill.swiftuiColor)
            .frame(width: 0.15 * geometry.size.width, height: 0.15 * geometry.size.width)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          Circle()
            .fill(HelloColor.mario.questionBlockFill.swiftuiColor)
            .frame(width: 0.15 * geometry.size.width, height: 0.15 * geometry.size.width)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
          Circle()
            .fill(HelloColor.mario.questionBlockFill.swiftuiColor)
            .frame(width: 0.15 * geometry.size.width, height: 0.15 * geometry.size.width)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
          Circle()
            .fill(HelloColor.mario.questionBlockFill.swiftuiColor)
            .frame(width: 0.15 * geometry.size.width, height: 0.15 * geometry.size.width)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }.padding(0.075 * geometry.size.width)
        Text("?")
          .font(.custom("LCD Solid", fixedSize: 0.9 * geometry.size.width))
          .offset(y: 0.05 * geometry.size.width)
      }.background(HelloColor.mario.questionBlock.swiftuiColor)
    }
  }
}
