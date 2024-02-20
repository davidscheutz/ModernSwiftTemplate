import Foundation

/// @Factory
/// @Loop(ListState, ListEvent)
final class ListLoop: GeneratedBaseListLoop {
    private let api: TodoApi
    private let bannerManager: BannerManager
    
    init(api: TodoApi, bannerManager: BannerManager) {
        self.api = api
        self.bannerManager = bannerManager
        super.init(initial: State.initial)
        
        loadTodos()
    }
    
    override func openTodo(state: State, id: String) {
        
    }
    
    override func logout(state: State) {
        
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
