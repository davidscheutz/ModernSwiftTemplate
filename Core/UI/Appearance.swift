import Foundation

public struct Appearance {
    public static let cornerRadius: CGFloat = 10
    
    public static func setup() {
        Poppins.register()
    }
}
