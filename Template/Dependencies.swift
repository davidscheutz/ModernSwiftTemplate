import Foundation
import Security
import SwiftDependencyContainer
import Core
import KeychainSwift
#if DEBUG
import Onboarding
import Todos
#endif

struct Dependencies: AutoSetup {
    let container = DependencyContainer()
    
    func override(_ container: DependencyContainer) throws {
        /*
         Examples of how to manually register third-party implementations
         */
        // TODO: test new @Alias annotation
        try container.register(LocalStorage.self) { UserDefaults(suiteName: "Template_LocalStorage") }
        try container.register(SecureStorage.self) { KeychainSwift(keyPrefix: "Template_SecureStorage") }
        
        /*
         Example of how to manually constructor inject another dependency
         */
        try container.register { ApiConfig(baseUrl: "https://example.server.com/api", authStore: resolve()) }
        
        /*
         Example of how to replace a component of your application,
         in this case with a mock, which should be avoided but can be useful
         e.g. when you have the API contract is ready but not yet hosted.
         */
        try container.register(HttpEngine.self) {
            #if DEBUG
            HttpEngineMock()
                .register(OnboardingApiMock())
                .register(TodoApiMock())
            #else
            HttpEngineImpl()
            #endif
        }
    }
}
