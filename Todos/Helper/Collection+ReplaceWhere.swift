import Foundation

// TODO: move to SwiftEvolution
extension Array {
    mutating func replace(using element: Element, where find: (Element) -> Bool) {
        if let index = firstIndex(where: find) {
            self[index] = element
        }
    }
}
