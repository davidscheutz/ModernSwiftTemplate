import Combine
import Core

/// @Factory
/// @Loop(ListState, ListEvent)
final class ListLoop: GeneratedBaseListLoop {
    private let todosService: TodosService
    private let authManager: AuthenticationManager
//    private let navigation: Navigation
    
    init(todosService: TodosService, authManager: AuthenticationManager) { //, navigation: Navigation
        self.todosService = todosService
        self.authManager = authManager
//        self.navigation = navigation
        super.init(initial: State.initial)
        
        loadTodos()
    }
    
    override func openTodo(id: String) {
//        navigation.openDetail(with: id)
    }
    
    override func logout() {
        Task {
            await authManager.logout()
        }
    }
    
    override func createTodo() {
//        navigation.openCreateTodo()
    }
    
//    private let mutableState: CurrentValueSubject<State, Never>

    func assign<T, Value, Source: Publisher<T, Never>>(
        to keyPath: KeyPath<State, Value>,
        _ source: Source,
        map: (T) -> Value
    ) {
//        currentState[keyPath: <#T##KeyPath<GeneratedBaseListLoop.State, Value>#>]
//        source.map { map($0) }.sink {  }
        
//        currentState[keyPath: keyPath] = map()
    }
    
    private func loadTodos() {
        update { $0.copy(todos: .loading) }
        
//        subscribe(todosService.todos, \.todos)
        
//        todosService.todos.sink(receiveValue: <#T##(([Todo]) -> Void)##(([Todo]) -> Void)##([Todo]) -> Void#>).store(in: &<#T##RangeReplaceableCollection#>)
//        todosService.todos.assign(to: <#T##ReferenceWritableKeyPath<Root, [Todo]>#>, on: <#T##Root#>)
        
//        assign(to: \.todos, todosService.todos) { .loaded(data: $0) }
//        assign(to: \.todos, todosService.todos)
//
//        Task {
//            do {
//                let todos = try await api.todos()
//                update { $0.copy(todos: .loaded(data: todos)) }
//            } catch let error {
//                update { $0.copy(todos: .error(message: error.localizedDescription)) }
//            }
//        }
    }
}
