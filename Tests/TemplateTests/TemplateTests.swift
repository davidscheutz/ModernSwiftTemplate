import XCTest
@testable import Template

final class TemplateTests: XCTestCase {

    /// The Template app target is the composition root,
    /// it's main responsibility is to correctly assemble
    /// all components. This test ensure all dependencies
    /// can be resolved.
    func testDependencies() throws {
        try Dependencies.verifyResolvability()
    }
}
