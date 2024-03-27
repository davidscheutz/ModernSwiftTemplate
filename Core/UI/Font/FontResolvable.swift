import SwiftUI

protocol FontResolvable {
    var name: String { get }
    var fileName: String { get }
    var fileExtension: String { get }
    static var all: [Self] { get }
}

extension FontResolvable {
    static func register() {
        all.forEach { $0.register() }
    }
    
    var fileExtension: String { "ttf" }
    
    var bundle: Bundle { .core }
}

extension FontResolvable {
    func resolve(with size: CGFloat, relativeTo textStyle: Font.TextStyle) -> Font {
        .custom(name, size: size, relativeTo: textStyle)
    }
    
    func register() {
        guard let fontURL = bundle.url(forResource: fileName, withExtension: fileExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }
        
        var error: Unmanaged<CFError>?
        
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}
