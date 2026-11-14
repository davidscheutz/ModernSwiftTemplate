import Foundation

nonisolated struct TodoRequestBody: Codable, Sendable {
    let title: String
    let description: String?
    let completed: Bool
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
        self.completed = false // TODO: add to UI
    }
}
