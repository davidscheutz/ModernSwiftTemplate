import Foundation
import Core

public final class OnboardingApiMock: HttpInterceptable {
    public init() {}
    
    public func canHandle(_ request: URLRequest) -> Bool {
        guard let url = request.url?.absoluteString else { return false }
        return url.contains("login") || url.contains("logout")
    }
    
    public func handle<T>(_ request: URLRequest) async throws -> T where T : Decodable {
        switch T.self {
        case is LoginResponse.Type:
            if request.url?.absoluteString.contains("login") == true {
                return LoginResponse(accessToken: UUID().uuidString) as! T
            }
        case is Empty.Type:
            if request.url?.absoluteString.contains("logout") == true {
                return Empty() as! T
            }
            
        default: break
        }
        
        throw NSError(domain: "No mock registered for type: \(T.self)", code: 404)
    }
}
