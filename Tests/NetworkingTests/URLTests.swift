import XCTest
import Networking

final class URLTests: XCTestCase {

    func test_expressible_by_string_literal() throws {
        let url: URL = "https://example.org"

        XCTAssertEqual(url.absoluteString, "https://example.org")
    }

    func test_expressible_by_string_interpolation() {
        let url: URL = "https://example.org/order/\(123)"

        XCTAssertEqual(url.absoluteString, "https://example.org/order/123")
    }

    func test_equatable() throws {
        let url: URL = "https://example.org"
        let string: String = "https://example.org"

        XCTAssertTrue(url == string)
    }

}
