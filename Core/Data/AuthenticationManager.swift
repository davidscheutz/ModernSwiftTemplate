
public protocol AuthenticationManager {
    var isLoggedIn: Bool { get }
    func login(username: String, password: String) async throws
    func logout() async
}
