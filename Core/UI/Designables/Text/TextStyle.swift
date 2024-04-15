import SwiftUI

public class TextStyle {
    fileprivate let lineHeight: CGFloat
    fileprivate let size: CGFloat
    fileprivate let systemStyle: Font.TextStyle
    fileprivate let font: FontResolvable
    fileprivate let lineSpacing: CGFloat
    
    public static let headlineLarge = TextStyle(lineHeight: 36, size: 24, system: .largeTitle, font: Poppins.bold)
    public static let headline = TextStyle(lineHeight: 28, size: 22, system: .title, font: Poppins.semibold)
    public static let subheadline = TextStyle(lineHeight: 20, size: 18, system: .headline, font: Poppins.semibold)
    public static let title = TextStyle(lineHeight: 24, size: 16, system: .body, font: Poppins.regular)
    public static let body = TextStyle(lineHeight: 24, size: 14, system: .body, font: Poppins.regular)
    public static let footnote = TextStyle(lineHeight: 16, size: 12, system: .footnote, font: Poppins.light)
    
    init(
        lineHeight: CGFloat,
        size: CGFloat,
        system: Font.TextStyle,
        font: FontResolvable
    ) {
        self.lineHeight = lineHeight
        self.size = size
        self.systemStyle = system
        self.font = font
        lineSpacing =  max(0, (lineHeight - size) / 2)
    }
    
    func resolve() -> Font {
        font.resolve(with: size, relativeTo: systemStyle)
    }
}

extension Text {
    public func style(_ textStyle: TextStyle = .body, color: ColorStyle = .textPrimary, alignment: TextAlignment = .leading) -> some View {
        textAppearance(textStyle, colorStyle: color, alignment: alignment)
    }
}

extension SecureField {
    public func style(_ textStyle: TextStyle = .body, color: ColorStyle = .textPrimary, alignment: TextAlignment = .leading) -> some View {
        textAppearance(textStyle, colorStyle: color, alignment: alignment)
    }
}

extension TextField {
    public func style(_ textStyle: TextStyle = .body, color: ColorStyle = .textPrimary, alignment: TextAlignment = .leading) -> some View {
        textAppearance(textStyle, colorStyle: color, alignment: alignment)
    }
}

fileprivate extension View {
    func textAppearance(_ textStyle: TextStyle, colorStyle: ColorStyle, alignment: TextAlignment) -> some View {
        font(textStyle.resolve())
            .multilineTextAlignment(alignment)
            .lineSpacing(textStyle.lineSpacing)
            .foregroundColor(colorStyle.color)
    }
}
