import Foundation

public struct Appearance {
    public static let cornerRadius: CGFloat = 8
    
    public static func setup() {
        Poppins.register()
    }
}
