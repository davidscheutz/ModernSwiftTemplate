import Foundation

/// @Factory
/// @Loop(ListState, ListEvent)
final class ListLoop: GeneratedBaseListLoop {
    private let api: TodoApi
    private let authManager: AuthenticationManager
    private let navigation: Navigation
    
    init(api: TodoApi, authManager: AuthenticationManager, navigation: Navigation) {
        self.api = api
        self.authManager = authManager
        self.navigation = navigation
        super.init(initial: State.initial)
        
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
        update { $0.copy(todos: .loading) }
        
        Task {
            do {
                let todos = try await api.todos()
                update { $0.copy(todos: .loaded(data: todos)) }
            } catch let error {
                update { $0.copy(todos: .error(message: error.localizedDescription)) }
            }
        }
    }
}
