import XCTest
import Core
import SwiftDependencyContainer
@testable import Todos

@MainActor
final class TodosServiceTests: XCTestCase {
    
    let apiMock = TodosApiMock()
    var sut: TodosService!
    
    override func setUp() async throws {
        sut = TodosService(api: apiMock)
    }
    
    func test_optimisticUpdateAvailableOnFetchListFailure() async throws {
        let todo = Todo(
            id: "1", createdAt: .now, completed: false, title: "New", description: nil, updatedAt: nil
        )
        let updatedTodo = todo.copy(
            title: "Updated Title", description: .update("Updated Description"), updatedAt: .update(.now)
        )
        
        apiMock.todos = [[todo]]
        apiMock.updates[todo.id] = updatedTodo
        
        sut.load()
        
        try await waitUntil { !self.sut.todos.value.isEmpty }
        let todos = sut.todos.value
        XCTAssertEqual(todos.first, todo)
        
        try await sut.updateTodo(
            with: updatedTodo.id, title: updatedTodo.title, description: updatedTodo.description
        )
        
        XCTAssertEqual(sut.todos.value.first, updatedTodo)
    }
}

// MARK: Helper

extension Todo: @retroactive Equatable {
    public static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
        && lhs.createdAt == rhs.createdAt
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.updatedAt == rhs.updatedAt
    }
}

extension XCTestCase {
    @MainActor
    func waitUntil(timeout: TimeInterval = 1, _ check: @escaping () -> Bool) async throws {
        let deadline = Date().addingTimeInterval(timeout)
        while !check() {
            guard Date() < deadline else {
                throw NSError(domain: "Timeout for wait check...", code: 0)
            }
            try await Task.sleep(nanoseconds: 10_000_000)
        }
    }
}
