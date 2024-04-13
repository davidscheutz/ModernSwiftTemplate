import Combine
import Core

/// @Factory
/// @Loop(ListState, ListEvent)
final class ListLoop: GeneratedBaseListLoop {
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
        
        todosService.todos
            .sink { [weak self] in self?.updateTodos(.loaded(data: $0)) }
            .store(in: &subscriptions)
    }
}
