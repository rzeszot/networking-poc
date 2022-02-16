import XCTest
import Networking

final class ParserTests: XCTestCase {

    var sut: Parser!

    override func setUp() {
        sut = Parser(payloads: [
            SuccessPayload.self,
            AcceptedPayload.self,
            BadRequestPayload.self,
            SignedTeapodPayload.self
        ], decoder: JSONDecoder.default)
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: -

    func test_type_success() throws {
        let type = try sut.payload(for: .success)
        XCTAssertNotNil(type)
    }

    func test_type_accepted() throws {
        let type = try sut.payload(for: .accepted)
        XCTAssertNotNil(type)
    }

    func test_type_bad_request() throws {
        let type = try sut.payload(for: .badRequest)
        XCTAssertNotNil(type)
    }

    func test_type_unexpected() throws {
        let type = try sut.payload(for: .gone)
        XCTAssertNil(type)
    }

    // MARK: -

    func test_parse_success() throws {
        let object = try sut.parse(response: .success)
        XCTAssertEqual((object as? SuccessPayload)?.number, 42)
    }

    func test_parse_success_decoding_error() throws {
        do {
            _ = try sut.parse(response: .shrug)
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is DecodingError)
        }
    }

    func test_parse_unexpected_code() throws {
        do {
            _ = try sut.parse(response: .gone)
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is PayloadNotFoundError)
        }
    }

    func test_parse_signature_missing_signature() throws {
        XCTAssertThrowsError(try sut.parse(response: .teapod(signed: nil))) { error in
            XCTAssertTrue(error is PayloadNotFoundError)
        }
    }

    func test_parse_signature_invalid_signature() throws {
        XCTAssertThrowsError(try sut.parse(response: .teapod(signed: false))) { error in
            XCTAssertTrue(error is SignedTeapodPayload.InvalidSignatureError)
        }
    }

    func test_parse_signature_success() throws {
        let object = try sut.parse(response: .teapod(signed: true))
        XCTAssertEqual((object as? SignedTeapodPayload)?.payload.temperature, 93)
    }

}
