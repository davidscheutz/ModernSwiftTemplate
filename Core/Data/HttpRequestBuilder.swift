import Foundation

public final class HttpRequestBuilder {
    
    public enum HTTPMethod: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
        case patch = "PATCH"
    }
        
    private let url: String
    private let timeoutInterval: TimeInterval
    private var path = ""
    private var accessToken: String?
    private var httpMethod: HTTPMethod = .get
    private var headers: [String: Any]?
    private var body: Encodable?
    
    public init(url: String, timeoutInterval: TimeInterval = 30.0) {
        self.url = url
        self.timeoutInterval = timeoutInterval
    }
    
    public func path(_ path: String) -> HttpRequestBuilder {
        self.path = path
        return self
    }
    
    public func authenticate(_ accessToken: String) -> HttpRequestBuilder {
        self.accessToken = accessToken
        return self
    }
    
    public func authenticate(using storage: AuthenticationStore) throws -> HttpRequestBuilder {
        self.accessToken = storage.acccessToken
        return self
    }
    
    public func httpMethod(_ httpMethod: HTTPMethod) -> HttpRequestBuilder {
        self.httpMethod = httpMethod
        return self
    }
    
    public func headers(_ headers: [String: Any]) -> HttpRequestBuilder {
        self.headers = headers
        return self
    }
    
    public func body<T: Encodable>(_ body: T) -> HttpRequestBuilder {
        self.body = body
        return self
    }
    
    // MARK: Build
    
    public func build() throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw NSError(domain: "Invalid url: \(url)", code: 0)
        }
        var request = URLRequest(url: url.appendingPathComponent(path), timeoutInterval: timeoutInterval)
        
        request.httpMethod = httpMethod.rawValue
        
        if let accessToken {
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        headers?.forEach { request.addValue("\($0.value)", forHTTPHeaderField: $0.key) }
        
        if let body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
    
    // MARK: Execute
    
    public func execute<T: Decodable>(using engine: HttpEngine) async throws -> T {
        try await engine.execute(build())
    }
    
    public func execute(using engine: HttpEngine) async throws {
        try await engine.execute(build())
    }
}
