import SwiftEvolution
import SwiftDependencyContainer

public protocol AuthenticationManager {
    var isLoggedIn: CurrentValuePublisher<Bool> { get }
    func login(username: String, password: String) async throws
    func logout() async
}

public protocol AuthenticationStore: AnyObject {
    var acccessToken: String? { get set }
}

@Singleton(AuthenticationStore.self)
public final class AuthenticationStoreImpl: AuthenticationStore {
    private let storage: SecureStorage
    private let accessTokenKey = "API_ACCESS_TOKEN"
    
    public init(storage: SecureStorage) {
        self.storage = storage
    }
    
    public var acccessToken: String? {
        get { try? storage.value(for: accessTokenKey) }
        set { try! storage.store(newValue, for: accessTokenKey) }
    }
}
