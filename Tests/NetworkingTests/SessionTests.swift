import XCTest
@testable import Networking

final class SessionTests: XCTestCase {

    var session: SessionFake!
    var parser: Parser!
    
    override func setUp() {
        session = SessionFake()

        parser = Parser(payloads: [
            SuccessPayload.self,
            BadRequestPayload.self,
            TeapodPayload.self
        ], decoder: JSONDecoder.default)
    }
    
    // MARK: -

    func test_success() async throws {
        session.succeeds(response: .success)

        let result = try await session
            .execute(request: .example)
            .unpack(using: parser)
            .throw()
            .cast(as: SuccessPayload.self)
        
        XCTAssertEqual(result.number, 42)
    }
    
    func test_throw_error() async throws {
        session.succeeds(response: .badRequest)

        do {
            _ = try await session
                .execute(request: .example)
                .unpack(using: parser)
                .throw()
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is BadRequestPayload)
        }
    }
    
    func test_cast() async throws {
        session.succeeds(response: .success)
        
        do {
            _ = try await session
                .execute(request: .example)
                .unpack(using: parser)
                .throw()
                .cast(as: AcceptedPayload.self)
            XCTFail("XCTAssertThrowAwait")
        } catch {
            XCTAssertTrue(error is UnexpectedPayloadError)
        }
    }

}
