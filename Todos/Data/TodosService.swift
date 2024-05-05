import Foundation
import SwiftUDF
import SwiftEvolution

/// @Singleton
final class TodosService {
    let todos: CurrentValuePublisher<[Todo]>
    
    private let api: TodoApi
    private let source = MutableState<[Todo]>([])
    
    init(api: TodoApi) {
        self.api = api
        
        todos = .init(source)
    }
    
    func todo(with id: String) async throws -> Todo {
        try await api.todo(for: id)
    }
    
    @discardableResult
    func createTodo(title: String, description: String) async throws -> Todo {
        let todo = try await api.create(with: title, description: description)
        
        // insert optimistically
        source.append(todo)
        
        load()
        
        return todo
    }
    
    func updateTodo(with id: String, title: String, description: String) async throws {
        _ = try await api.update(with: id, title: title, description: description)
        
        load()
    }
    
    func deleteTodo(with id: String) async throws {
        try await api.delete(with: id)
        
        load()
    }
    
    func load() {
        source.await { (try? await self.api.todos()) ?? [] }
    }
}
