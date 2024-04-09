import Foundation

struct CreateTodoRequest: Codable {
    let title: String
    let description: String?
}
