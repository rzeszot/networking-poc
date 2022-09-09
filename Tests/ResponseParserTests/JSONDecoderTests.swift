import XCTest
import ResponseParser

final class JSONDecoderTests: XCTestCase {

    func test_decode() throws {
        let sut: [Payload.Type] = [SuccessPayload.self, AcceptedPayload.self]
        let response = HTTPURLResponse(statusCode: 200)

        guard let result = sut.filter(for: response).first as? SuccessPayload.Type else {
            throw FailError()
        }

        let data = """
            {
                "number" : 42
            }
            """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let object = try decoder.decode(result, from: data)

        XCTAssertEqual(object.number, 42)
    }

    private struct FailError: Error {}

}
