import Foundation
import Core

/// @Factory
/// @Loop(CreateState, CreateEvent)
final class CreateLoop: GeneratedBaseCreateLoop {
    private let service: TodosService
    private let navigation: Navigation
    
    init(service: TodosService, navigation: Navigation) {
        self.service = service
        self.navigation = navigation
        
        super.init(initial: .initial)
    }
    
    override func titleChanged(title: String) {
        guard !isLoading else { return }
        
        updateTitle(.update(title))
    }
    
    override func descriptionChanged(description: String) {
        guard !isLoading else { return }

        updateDescription(.update(description))
    }
    
    override func create() {
        guard !isLoading else { return }
                
        updateTitle(title.copy(error: .use("Can't be empty".take(if: title.value.isEmpty))))
        
        guard title.error == nil else { return }
        
        updateIsLoading(true)

        Task {
            do {
                _ = try await service.createTodo(title: title.value, description: description.value)
                navigation.closeSheet()
            } catch let error {
                update(isLoading: false, error: .use(error.localizedDescription))
            }
        }
    }
    
    override func close() {
        navigation.closeSheet()
    }
}
