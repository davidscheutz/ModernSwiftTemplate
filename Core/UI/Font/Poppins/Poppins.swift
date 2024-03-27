import Foundation

struct Poppins: FontResolvable {
    static let light = Poppins(typeFace: "Light")
    static let thin = Poppins(typeFace: "Thin")
    static let regular = Poppins(typeFace: "Regular")
    static let medium = Poppins(typeFace: "Medium")
    static let semibold = Poppins(typeFace: "SemiBold")
    static let bold = Poppins(typeFace: "Bold")
    
    private let typeFace: String
    
    var name: String {
        "Poppins-" + typeFace
    }
    
    var fileName: String {
        name
    }
    
    static var all: [Poppins] {
        [.light, .thin, .regular, .bold, .medium, .semibold, .bold]
    }
}
