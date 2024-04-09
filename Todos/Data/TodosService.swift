import Foundation
import SwiftUDF

/// @Singleton
final class TodosService {
    let todos: CurrentValuePublisher<[Todo]>
    
    private let api: TodoApi
    private let source = MutableState<[Todo]>([])
    
    init(api: TodoApi) {
        self.api = api
        
        todos = .init(source)
        
        load()
    }
    
    func todo(with id: String) async throws -> Todo {
        try await api.todo(for: id)
    }
    
    @discardableResult
    func createTodo(title: String, description: String) async throws -> Todo {
        let todo = try await api.create(with: title, description: description)
        
        // optimistic update
//        source.append(todo)
        
        load()
        
        return todo
    }
    
    func load() {
        source.await { (try? await self.api.todos()) ?? [] }
    }
}
