import XCTest
import ResponseParser

final class EndToEndTests: XCTestCase {

    func test_418() async throws {
        let sut = TeapodService(client: .returning(data: "{}".data(using: .utf8)!, response: .init(statusCode: 418)))
        let result = try await sut.temperature()
        XCTAssertEqual(result, 100)
    }

    func test_200() async throws {
        let data = """
            {
                "temperature" : 42
            }
            """.data(using: .utf8)!
        let sut = TeapodService(client: .returning(data: data, response: .init(statusCode: 200)))
        let result = try await sut.temperature()
        XCTAssertEqual(result, 42)
    }

}
