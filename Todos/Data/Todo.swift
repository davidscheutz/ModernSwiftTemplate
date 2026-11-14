import Foundation
import SwiftCopy

nonisolated struct Todo: Decodable, Identifiable, Copyable, Sendable {
    let id: String
    let createdAt: Date
    let completed: Bool
    let title: String
    let description: String?
    let updatedAt: Date?
}
