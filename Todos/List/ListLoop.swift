import Combine
import Core
import SwiftDependencyContainer
import SwiftUDF

@Factory
@Loop(in: ListEvent.self, out: ListState.self)
final class ListLoop: ListLoopBaseGenerated {
    private let todosService: TodosService
    private let authManager: AuthenticationManager
    private let navigation: Navigation
    
    init(todosService: TodosService, authManager: AuthenticationManager, navigation: Navigation) {
        self.todosService = todosService
        self.authManager = authManager
        self.navigation = navigation
        super.init(initial: State.initial)
    }
    
    override func start() {
        todosService.todos
            .sink { [weak self] in self?.updateTodos(.loaded(data: $0)) }
            .store(in: &subscriptions)
        
        loadTodos()
    }
    
    override func openTodo(id: String) {
        navigation.openDetail(with: id)
    }
    
    override func logout() {
        Task {
            await authManager.logout()
        }
    }
    
    override func createTodo() {
        navigation.openCreateTodo()
    }
    
    private func loadTodos() {
        updateTodos(.loading)
        todosService.load()
    }
}
