import Foundation
import Core

/// @Factory
/// @Loop(CreateState, CreateEvent)
final class CreateLoop: GeneratedBaseCreateLoop {
    private let service: TodosService
    private let navigation: Navigation
    private let bannerManager: BannerManager
    
    init(service: TodosService, bannerManager: BannerManager, navigation: Navigation) {
        self.service = service
        self.navigation = navigation
        self.bannerManager = bannerManager
        
        super.init(initial: .initial)
    }
    
    override func titleChanged(title: String) {
        guard !isLoading else { return }
        
        updateTitle { $0.update(title) }
        
        // TODO: add easy update support for 'Input' type
        /*
         update { $0.copy(title: title) }
         update { title(title) }
         */
    }
    
    override func descriptionChanged(title: String) {
        guard !isLoading else { return }

        updateDescription { $0.update(title) }
    }
    
    override func create() {
        guard !isLoading else { return }
                
        updateTitle(title.copy(error: .use("Can't be empty".take(if: title.value.isEmpty))))
        
        guard title.error == nil else { return }
        
        updateIsLoading(true)

        Task {
            do {
                _ = try await service.createTodo(title: title.value, description: description.value)
                bannerManager.present(.success("New Todo created"))
                navigation.closeSheet()
            } catch let error {
                bannerManager.present(.error(error.localizedDescription))
            }
        }
    }
    
    override func close() {
        navigation.closeSheet()
    }
}
