import Foundation
import SwiftCopy

public struct Todo: Decodable, Identifiable, Copyable {
    public init(id: String, createdAt: Date, completed: Bool, text: String, updatedAt: Date? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.completed = completed
        self.text = text
        self.updatedAt = updatedAt
    }
    
    public let id: String
    public let createdAt: Date
    public let completed: Bool
    public let text: String
    public let updatedAt: Date?
}
