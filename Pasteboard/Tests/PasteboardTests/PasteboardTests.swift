import XCTest
@testable import Pasteboard

final class PasteboardTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Pasteboard().text, "Hello, World!")
    }
}
