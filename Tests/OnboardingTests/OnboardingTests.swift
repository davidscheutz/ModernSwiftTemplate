import XCTest
@testable import Onboarding

final class OnboardingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let authMock = AuthenticationManagerMock()
        let sut = LoginLoop(authenticationManager: authMock)
        
//        XCTAssertEqual(sut.currentState, .initial)
//        
//        var results = [LoginState]()
//        var cancellable = sut.state.sink { results.append($0) }
//        
//        sut.inputChanged(field: <#T##Input.Field#>, value: <#T##String#>)
//        
//        cancellable.cancel()
    }
}

import Combine

// TODO: try to fix 'Escaping closure captures 'inout' parameter 'source''
extension Publisher where Failure == Never {
//    func assign(to source: inout [Output]) -> Cancellable {
//        sink { source.append($0) }
//    }
}

// Error: 'Escaping closure captures mutating 'self' parameter'
//extension Array {
//    mutating func append<P: Publisher>(from source: P) -> Cancellable where Element == P.Output, P.Failure == Never {
//        source.sink { append($0) }
//    }
//}
