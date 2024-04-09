import Foundation
import SwiftCopy

struct Todo: Decodable, Identifiable, Copyable {
    let id: String
    let createdAt: Date
    let completed: Bool
    let title: String
    let description: String?
    let updatedAt: Date?
}
