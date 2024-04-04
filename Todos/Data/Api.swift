import Foundation
import Core

protocol TodoApi {
    func todos() async throws -> [Todo]
    func create(with title: String, description: String?) async throws -> Todo
    func todo(for id: String) async throws -> Todo
}

/// @Singleton(types: [TodoApi])
final class TodoApiImpl: TodoApi {
    
    public init(httpEngine: HttpEngine) {
        self.httpEngine = httpEngine
    }
    
    private let baseUrl = "https://myserver.com/api/v1"
    private let httpEngine: HttpEngine
    
    func todos() async throws -> [Todo] {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/todos")!))
    }
    
    func create(with title: String, description: String?) async throws -> Todo {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/todo")!))
    }
    
    func todo(for id: String) async throws -> Todo {
        try await httpEngine.execute(URLRequest(url: .init(string: baseUrl + "/todos/\(id)")!))
    }
}

// TODO: finish
public struct TodoApiMock: HttpInterceptable {
    
    private let todos = [
        Todo(id: "1", createdAt: .now, completed: false, text: "Master", updatedAt: nil),
        Todo(id: "2", createdAt: .now, completed: false, text: "Relax", updatedAt: nil),
        Todo(id: "3", createdAt: .now, completed: false, text: "Enjoy", updatedAt: nil)
    ]
    
    public init() {}
    
    public func canHandle(_ request: URLRequest) -> Bool {
        request.url?.absoluteString.contains("todo") == true
    }
    
    public func handle<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        switch T.self {
        case is [Todo].Type:
            return todos as! T
        case is Todo.Type:
            if let id = Int(request.url!.absoluteString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                // get by ID
                guard let todo = todos.first(where: { $0.id == "\(id)" }) else {
                    throw NSError(domain: "No todo found for ID: \(id)", code: 404)
                }
                return todo as! T
            } else {
                // create
                // TODO: use values from request body
                return Todo(id: UUID().uuidString, createdAt: .now, completed: false, text: "Mock Todo", updatedAt: nil) as! T
            }
        default: throw NSError(domain: "No mock registered for type: \(T.self)", code: 404)
        }
    }
}
