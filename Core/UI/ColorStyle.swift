import SwiftUI

public enum ColorStyle {
    case textPrimary
    case textSecondary
    case textInverted
    case textLight
    case error
    case action
    case background
    
    var color: Color {
        switch self {
        case .textPrimary: return Color.textPrimary
        case .textSecondary: return Color.textSecondary
        case .textInverted: return Color.textInverted
        case .textLight: return Color.textLight
        case .error: return Color.error
        case .action: return Color.action
        case .background: return Color.background
        }
    }
}

extension View {
    public func foreground(_ colorStyle: ColorStyle) -> some View {
        foregroundStyle(colorStyle.color)
    }
    
    public func background() -> some View {
        background(colorStyle: .background)
    }
    
    public func background(colorStyle: ColorStyle = .background) -> some View {
        background(colorStyle.color.ignoresSafeArea())
    }
}
