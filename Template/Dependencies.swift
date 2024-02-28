import Foundation
import SwiftDependencyContainer

struct Dependencies: AutoSetup {
    let container = DependencyContainer()
    
    func override(_ container: DependencyContainer) throws {
        try container.register(Storage.self) { UserDefaults(suiteName: "Template") }
        
        #if DEBUG
        try container.register(HttpEngine.self) { HttpEngineMock() }
        #else
        try container.register(HttpEngine.self) { HttpEngineImpl() }
        #endif
    }
}
