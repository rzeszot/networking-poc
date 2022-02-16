import XCTest
import Networking

final class URLRequestTests: XCTestCase {

    // MARK: - JSONEncoder

    func test_json_encoded_body() throws {
        var request = URLRequest.example
        try request.body(json: TeapodPayload(temperature: 93))

        XCTAssertEqual(request.httpBody, Data.temperature)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/json")
    }

    // MARK: - PlistEncoder

    func test_plist_encoded_body() throws {
        var request = URLRequest.example
        try request.body(plist: TeapodPayload(temperature: 93))

        XCTAssertEqual(request.httpBody, Data.plist)
        XCTAssertEqual(request.value(forHTTPHeaderField: "Content-Type"), "application/plist")
    }

    // MARK: - Method

    func test_get_http_method() {
        let request = URLRequest(.get, .example)
        XCTAssertEqual(request.httpMethod, "GET")
    }

    func test_head_http_method() {
        let request = URLRequest(.head, .example)
        XCTAssertEqual(request.httpMethod, "HEAD")
    }

    func test_post_http_method() {
        let request = URLRequest(.post, .example)
        XCTAssertEqual(request.httpMethod, "POST")
    }

    func test_put_http_method() {
        let request = URLRequest(.put, .example)
        XCTAssertEqual(request.httpMethod, "PUT")
    }

    func test_patch_http_method() {
        let request = URLRequest(.patch, .example)
        XCTAssertEqual(request.httpMethod, "PATCH")
    }

    func test_delete_http_method() {
        let request = URLRequest(.delete, .example)
        XCTAssertEqual(request.httpMethod, "DELETE")
    }

    func test_custom_http_method() {
        let request = URLRequest(.custom, .example)
        XCTAssertEqual(request.httpMethod, "CUSTOM")
    }

    func test_string_http_method() {
        let request = URLRequest("string", .example)
        XCTAssertEqual(request.httpMethod, "STRING")
    }

}
