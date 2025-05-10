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
         Examples of how to decouple third-party implementations
         */
        try container.register(LocalStorage.self) { UserDefaults(suiteName: "Template_LocalStorage") }
        try container.register(SecureStorage.self) { KeychainSwift(keyPrefix: "Template_SecureStorage") }
        
        /*
         Example of how to manually register a dependency
         */
        try container.register { ApiConfig(baseUrl: "https://example.server.com/api", authStore: resolve()) }
        
        /*
         Example of how to replace a component of your application.
         */
        try container.register(HttpEngine.self) {
            #if DEBUG
            /*
             Mocks in general should be avoided, but can be useful in certain scenarios
             e.g. when you have the API contract is defined but not yet available to the client.
             */
            HttpEngineMock()
                .register(OnboardingApiMock())
                .register(TodoApiMock())
            #else
            HttpEngineImpl()
            #endif
        }
    }
}
