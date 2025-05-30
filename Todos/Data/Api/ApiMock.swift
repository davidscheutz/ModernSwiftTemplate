import Foundation
import Core

public final class TodoApiMock: HttpInterceptable {
    
    private(set) var todos = [
        Todo(id: "1", createdAt: .now, completed: false, title: "Master", description: nil, updatedAt: nil),
        Todo(id: "2", createdAt: .now, completed: false, title: "Relax", description: "Preferably outside", updatedAt: nil),
        Todo(id: "3", createdAt: .now, completed: false, title: "Enjoy", description: nil, updatedAt: nil)
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
            switch HttpRequestBuilder.HTTPMethod(rawValue: request.httpMethod ?? "") {
            case .get:
                if let id = id(from: request) {
                    // get by ID
                    guard let todo = todos.first(where: { $0.id == id }) else {
                        throw NSError(domain: "No todo found for ID: \(id)", code: 404)
                    }
                    return todo as! T
                }
            case .patch:
                if let id = id(from: request) {
                    // get by ID
                    guard let index = todos.firstIndex(where: { $0.id == id }) else {
                        throw NSError(domain: "No todo found for ID: \(id)", code: 404)
                    }
                    let body = try JSONDecoder().decode(TodoRequestBody.self, from: request.httpBody!)
                    let todo = todos[index]
                    let updated = Todo(id: todo.id, createdAt: todo.createdAt, completed: body.completed, title: body.title, description: body.description, updatedAt: Date())
                    todos[index] = updated
                    return updated as! T
                }
            case .post:
                let body = try JSONDecoder().decode(TodoRequestBody.self, from: request.httpBody!)
                let todo = Todo(id: "\(abs(UUID().uuidString.hashValue))", createdAt: .now, completed: false, title: body.title, description: body.description, updatedAt: nil)
                todos.append(todo)
                return todo as! T
            default: break
            }
        case is Empty.Type:
            switch HttpRequestBuilder.HTTPMethod(rawValue: request.httpMethod ?? "") {
            case .delete:
                if request.httpMethod == HttpRequestBuilder.HTTPMethod.delete.rawValue, let id = id(from: request) {
                    todos.removeAll(where: { $0.id == id })
                    return Empty() as! T
                }
            default: break
            }
        default: break
        }
        
        throw NSError(domain: "No mock registered for type: \(T.self)", code: 404)
    }
    
    private func id(from request: URLRequest) -> String? {
        if let id = Int(request.url!.absoluteString.replacingOccurrences(of: "v1", with: "").components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
            return "\(id)"
        } else {
            return nil
        }
    }
}

