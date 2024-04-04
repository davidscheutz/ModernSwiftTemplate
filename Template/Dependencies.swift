import Foundation
import SwiftDependencyContainer
import Core
#if DEBUG
import Onboarding
import Todos
#endif

struct Dependencies: AutoSetup {
    let container = DependencyContainer()
    
    func override(_ container: DependencyContainer) throws {
        try container.register(Storage.self) { UserDefaults(suiteName: "Template") }
        
        try container.register(HttpEngine.self) {
            #if DEBUG
            HttpEngineMock()
                .register(TodoApiMock())
            #else
            HttpEngineImpl()
            #endif
        }
    }
}
