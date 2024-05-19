import XCTest
import Core
import SwiftDependencyContainer
@testable import Todos

final class TodosServiceTests: XCTestCase {
    
    let apiMock = TodosApiMock()
    var sut: TodosService!
    
    override func setUpWithError() throws {
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
        
        let todos = try await sut.todos.collectFirst(where: { !$0.isEmpty })
        XCTAssertEqual(todos.first, todo)
        
        try await sut.updateTodo(
            with: updatedTodo.id, title: updatedTodo.title, description: updatedTodo.description
        )
        
        XCTAssertEqual(sut.todos.value.first, updatedTodo)
    }
}

// MARK: Helper

extension Todo: Equatable {
    public static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
        && lhs.createdAt == rhs.createdAt
        && lhs.title == rhs.title
        && lhs.description == rhs.description
        && lhs.updatedAt == rhs.updatedAt
    }
}
