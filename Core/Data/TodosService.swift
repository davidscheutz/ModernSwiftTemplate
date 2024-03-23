import Foundation
import SwiftUDF

/// @Singleton
public final class TodosService {
//    public let todos: CurrentValuePublisher<[Todo]>
    
    private let api: TodoApi
//    private let source = MutableState<[Todo]>([])
    
    public init(api: TodoApi) {
        self.api = api
        
//        todos = .init(source)
        
        load()
    }
    
    @discardableResult
    public func createTodo(title: String, description: String) async throws -> Todo {
        let todo = try await api.create(with: title, description: description)
        
        // optimistic update
//        source.append(todo)
        
        load()
        
        return todo
    }
    
    private func load() {
//        source.await { (try? await self.api.todos()) ?? [] }
    }
}
