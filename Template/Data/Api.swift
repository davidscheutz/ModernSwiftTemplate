import Foundation

protocol UserApi {}

protocol TodoApi {
    func todos() async throws -> [Todo]
}

protocol Api: UserApi, TodoApi {}

/// @Singleton
struct HttpEngine {}

/// @Singleton(types: [Api, UserApi, TodoApi])
final class ApiImpl: Api {
    
    enum ApiError: Error {}
    
    init(httpEngine: HttpEngine) {}
    
    func todos() async throws -> [Todo] {
//        try await httpEngine.execute(.get, url: "\(baseUrl)/todos")
        [
            .init(id: "1", createdAt: .now, completed: false, text: "Master", updatedAt: nil),
            .init(id: "2", createdAt: .now, completed: false, text: "Relax", updatedAt: nil),
            .init(id: "3", createdAt: .now, completed: false, text: "Enjoy", updatedAt: nil)
        ]
    }
}
