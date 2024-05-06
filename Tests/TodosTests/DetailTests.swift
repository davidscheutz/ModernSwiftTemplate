import XCTest
import Core
import SwiftDependencyContainer
@testable import Todos

final class DetailTests: XCTestCase {
    
    let api = TodoApiMock()
    var container: DependencyContainer!
    
    override func setUpWithError() throws {
        container = DependencyContainer()
        
        // register all required dependencies
        try TodosContainer.register(using: container)
        try CoreContainer.register(using: container)
        
        try container.register(HttpEngine.self) { HttpEngineMock().register(self.api) }
        try container.register { ApiConfig(baseUrl: "tests", authStore: try! self.container.resolve()) }
        
        try container.register(LocalStorage.self) { InMemoryStorage() }
        try container.register(SecureStorage.self) { InMemoryStorage() }
    }

    func test_initialStateLoadedWithNoChanges() async throws {
        let sut = createSut()
        
        XCTAssertFalse(sut.hasChanges)
        
        try await sut.wait { $0.todo.loaded != nil }
    }
    
    func test_unknownTodoId() async throws {
        let sut = createSut(id: "unknwon")
        
        try await sut.wait { $0.todo.isError }
        
        XCTAssertNil(sut.todo.loaded)
    }
    
    // MARK: - Helper
    
    private func createSut() -> DetailLoop {
        createSut(id: api.todos[0].id)
    }
    
    private func createSut(id: String) -> DetailLoop {
        let sut = DetailLoop.create(id: id, with: container)
        sut.start()
        return sut
    }
}
