import XCTest
@testable import SimpleDie

final class SimpleDieTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SimpleDie().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
