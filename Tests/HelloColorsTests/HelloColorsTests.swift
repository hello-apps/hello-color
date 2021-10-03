import XCTest
@testable import HelloColors

final class HelloColorsTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HelloColors().text, "Hello, World!")
    }
}
