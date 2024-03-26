import Foundation
import Core

/// @Factory
/// @Loop(CreateState, CreateEvent)
final class CreateLoop: GeneratedBaseCreateLoop {
    private let api: TodoApi
    private let navigation: Navigation
    private let bannerManager: BannerManager
    
    init(api: TodoApi, bannerManager: BannerManager, navigation: Navigation) {
        self.api = api
        self.navigation = navigation
        self.bannerManager = bannerManager
        
        super.init(initial: .initial)
    }
    
    // TODO: fix parameter name codegen
    override func titleChanged(string: String) {
        guard !currentState.isLoading else { return }
        
        update { $0.copy(title: $0.title.update(string)) }
    }
    
    override func descriptionChanged(string: String) {
        guard !currentState.isLoading else { return }
        
        update { $0.copy(description: $0.description.update(string)) }
    }
    
    override func create() {
        guard !currentState.isLoading else { return }
        
        update { $0.copy(isLoading: true) }
        
        // TODO: Input validation
        
        Task {
            do {
                _ = try await api.create(with: currentState.title.value, description: currentState.description.value)
                bannerManager.present(.success("New Todo created"))
//                navigation.closeSheet()
            } catch let error {
                bannerManager.present(.error(error.localizedDescription))
            }
        }
    }
    
    override func close() {
        navigation.closeSheet()
    }
}
