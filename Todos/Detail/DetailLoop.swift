import Foundation
import SwiftUDF
import Core

/// @Factory
/// @Loop(DetailState, DetailEvent)
final class DetailLoop: GeneratedBaseDetailLoop {
    private let id: String
    private let todosService: TodosService
    private let navigation: Navigation
    
    init(
        // sourcery: configurable
        id: String,
        todosService: TodosService,
        navigation: Navigation
    ) {
        self.id = id
        self.todosService = todosService
        self.navigation = navigation

        super.init(initial: State(todo: .loading, updatedTitle: .empty, updatedDescription: .empty, isUpdating: false, isDeleting: false, error: nil))
    }

    override func start() {
        Task { @MainActor in
            do {
                let todo = try await todosService.todo(with: id)
                updateTodo(.loaded(data: todo))
            } catch let error {
                updateTodo(.error(message: error.localizedDescription))
            }
        }
    }
    
    override func titleChanged(title: String) {
        guard !isLoading else { return }
        updateUpdatedTitle(.update(title))
    }
    
    override func descriptionChanged(description: String) {
        guard !isLoading else { return }
        updateUpdatedDescription(.update(description))
    }
    
    override func update() {
        guard hasChanges else {
            close()
            return
        }
        
        guard !isLoading else { return }
        
        updateIsUpdating(true)
        
        Task {
            do {
                try await todosService.updateTodo(with: id, title: title.value, description: description.value)
                updateIsUpdating(false)
                close()
            } catch {
                update(isUpdating: false, error: .use(error.localizedDescription))
            }
        }
    }
    
    override func delete() {
        guard !isLoading else { return }
        
        updateIsDeleting(true)
        
        Task {
            do {
                try await todosService.deleteTodo(with: id)
                updateIsDeleting(false)
                close()
            } catch {
                update(isDeleting: false, error: .use(error.localizedDescription))
            }
        }
    }
    
    override func close() {
        guard !isLoading else { return }
        navigation.closeDetail()
    }
}
