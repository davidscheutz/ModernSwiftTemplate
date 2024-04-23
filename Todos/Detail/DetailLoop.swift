import Foundation
import SwiftUDF
import Core

/// @Factory
/// @Loop(DetailState, DetailEvent)
final class DetailLoop: GeneratedBaseDetailLoop {
    private let id: String
    private let todosService: TodosService
    private let navigation: Navigation
    private let bannerManager: BannerManager
    
    init(
        // sourcery: configurable
        id: String,
        todosService: TodosService,
        navigation: Navigation,
        bannerManager: BannerManager
    ) {
        self.id = id
        self.todosService = todosService
        self.navigation = navigation
        self.bannerManager = bannerManager

        super.init(initial: State(todo: .initial, updatedTitle: .empty, updatedDescription: .empty, isUpdating: false, isDeleting: false))
    }

    override func start() {
        Task { @MainActor in
            // TODO: replace with subscription
            updateTodo(.loaded(data: try await todosService.todo(with: id)))
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
        
        // TODO: wrap async operation within loop function e.g. 'executeAsync {}'
        Task {
//            try await todosService.updateTodo(title: )
        }
    }
    
    override func delete() {
        guard !isLoading else { return }
        
        updateIsDeleting(true)
        
        Task {
            do {
                try await todosService.deleteTodo(with: id)
                
                navigation.closeDetail()
            } catch let error {
                // TODO: display error
                updateIsDeleting(false)
            }
        }
    }
    
    override func close() {
        guard !isLoading else { return }
        navigation.closeDetail()
    }
}
