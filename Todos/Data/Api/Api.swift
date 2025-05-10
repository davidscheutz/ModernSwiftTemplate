import Foundation
import Core
import SwiftDependencyContainer

protocol TodoApi {
    func todos() async throws -> [Todo]
    func create(with title: String, description: String?) async throws -> Todo
    func update(with id: String, title: String, description: String?) async throws -> Todo
    func delete(with id: String) async throws
    func todo(for id: String) async throws -> Todo
}

@Singleton(TodoApi.self)
final class TodoApiImpl: TodoApi {
    
    init(httpEngine: HttpEngine, config: ApiConfig) {
        self.baseUrl = config.baseUrl
        self.httpEngine = httpEngine
        self.authStore = config.authStore
    }
    
    private let baseUrl: String
    private let httpEngine: HttpEngine
    private let authStore: AuthenticationStore
    
    func todos() async throws -> [Todo] {
        try await HttpRequestBuilder(url: baseUrl)
            .path("todos")
            .authenticate(using: authStore)
            .execute(using: httpEngine)
    }
    
    func create(with title: String, description: String?) async throws -> Todo {
        try await HttpRequestBuilder(url: baseUrl)
            .path("todos")
            .authenticate(using: authStore)
            .httpMethod(.post)
            .body(TodoRequestBody(title: title, description: description))
            .execute(using: httpEngine)
    }
    
    func update(with id: String, title: String, description: String?) async throws -> Todo {
        try await HttpRequestBuilder(url: baseUrl)
            .path("todos/\(id)")
            .authenticate(using: authStore)
            .httpMethod(.patch)
            .body(TodoRequestBody(title: title, description: description))
            .execute(using: httpEngine)
    }
    
    func delete(with id: String) async throws {
        try await HttpRequestBuilder(url: baseUrl)
            .path("todos/\(id)")
            .authenticate(using: authStore)
            .httpMethod(.delete)
            .execute(using: httpEngine)
    }
    
    func todo(for id: String) async throws -> Todo {
        try await HttpRequestBuilder(url: baseUrl)
            .path("todos/\(id)")
            .authenticate(using: authStore)
            .execute(using: httpEngine)
    }
}
