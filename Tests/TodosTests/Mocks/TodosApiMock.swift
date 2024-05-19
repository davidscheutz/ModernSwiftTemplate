import Foundation
import Core
@testable import Todos

class TodosApiMock: TodoApi {
    
    var todos = [[Todo]]()
    var updates = [String: Todo]()
    
    func todos() async throws -> [Todo] {
        if !todos.isEmpty {
            return todos.removeFirst()
        } else {
            throw NSError(domain: "Values missing", code: 0)
        }
    }
    
    func create(with title: String, description: String?) async throws -> Todo {
        throw NSError(domain: "Not implemented", code: 0)
    }
    
    func update(with id: String, title: String, description: String?) async throws -> Todo {
        if let updated = updates[id] {
            return updated
        } else {
            throw NSError(domain: "Value missing", code: 0)
        }
    }
    
    func delete(with id: String) async throws {
        throw NSError(domain: "Not implemented", code: 0)
    }
    
    func todo(for id: String) async throws -> Todo {
        throw NSError(domain: "Not implemented", code: 0)
    }
}
