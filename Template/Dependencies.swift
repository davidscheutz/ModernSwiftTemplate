import Foundation
import SwiftDependencyContainer

struct Dependencies: AutoSetup {
    let container = DependencyContainer()
    
    func override(_ container: DependencyContainer) throws {
        try container.register(Storage.self) { UserDefaults(suiteName: "Template") }
    }
    
//    static var storage: Storage { resolve() }
}

/*
 func override() {
    register(StorageRegistry())
    register(ComplexStorageRegistry())
 }
 
 func override(_ container: DependencyContainer) throws {
     try container.add(for: Storage.self) { UserDefaults(suiteName: "Template") }
 }
 
 class StorageRegistry: Registerable<Storage> {
    func build() -> UserDefaults {
        UserDefaults(suiteName: "Template")
    }
 }
 
 class ComplexStorageRegistry: Registerable<Storage1, Storage1> {
    func build() -> UserDefaults {
        UserDefaults(suiteName: "Template")
    }
 }
 */

/*
 struct Override<T> {
 let types: [Any]
 let builder: () -> T
 }
 */

