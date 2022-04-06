import XCTest
import ResponseParser

final class ParserTests: XCTestCase {

    var sut: Parser!

    override func setUp() {
        sut = [
            SuccessPayload.self,
            BadRequestPayload.self,
            SignedTeapodPayload.self
        ]
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: -

    func test_type_success() throws {
        let type = try sut.payload(for: Fixture.success.0)
        XCTAssertNotNil(type)
    }

    func test_type_bad_request() throws {
        let type = try sut.payload(for: Fixture.badRequest.0)
        XCTAssertNotNil(type)
    }

    func test_type_unexpected() throws {
        let type = try sut.payload(for: Fixture.gone.0)
        XCTAssertNil(type)
    }

    // MARK: -

    func test_parse_success() throws {
        let object = try sut.parse(Fixture.number42)
        XCTAssertEqual((object as? SuccessPayload)?.number, 42)
    }

    func test_parse_success_decoding_error() throws {
        do {
            _ = try sut.parse(Fixture.shrug)
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_parse_unexpected_code() throws {
        do {
            _ = try sut.parse(Fixture.gone)
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is PayloadNotFoundError)
        }
    }

    func test_parse_signature_missing_signature() throws {
        XCTAssertThrowsError(try sut.parse(Fixture.teapod(signed: nil))) { error in
            XCTAssertTrue(error is PayloadNotFoundError)
        }
    }

    func test_parse_signature_invalid_signature() throws {
        XCTAssertThrowsError(try sut.parse(Fixture.teapod(signed: false))) { error in
            XCTAssertTrue(error is SignedTeapodPayload.InvalidSignatureError)
        }
    }

    func test_parse_signature_success() throws {
        let object = try sut.parse(Fixture.teapod(signed: true))
        XCTAssertEqual((object as? SignedTeapodPayload)?.payload.temperature, 93)
    }

}

private extension Parser {
    func parse(_ tuple: (response: HTTPURLResponse, data: Data)) throws -> Payload {
        try parse(response: tuple.response, data: tuple.data)
    }
}
