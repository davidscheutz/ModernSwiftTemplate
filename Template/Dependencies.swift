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
        try container.register(LocalStorage.self) { UserDefaults(suiteName: "Template_LocalStorage") }
        try container.register(SecureStorage.self) { KeychainSwift(keyPrefix: "Template_SecureStorage") }
        
        try container.register { ApiConfig(baseUrl: "https://example.server.com/api", authStore: resolve()) }
        
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
