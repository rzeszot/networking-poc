import XCTest
import ResponseParser

final class PayloadByStatusCodeTests: XCTestCase {

    func test_status_code_accepted() {
        let sut = AcceptedPayload.self
        XCTAssertTrue(sut.satisfied(by: HTTPURLResponse(statusCode: 202)))
    }

    func test_status_code_success() {
        let sut = AcceptedPayload.self
        XCTAssertFalse(sut.satisfied(by: HTTPURLResponse(statusCode: 200)))
    }

    func test_collection_success() {
        let sut: [Payload.Type] = [SuccessPayload.self, AcceptedPayload.self]
        let result = sut.filter(for: HTTPURLResponse(statusCode: 200))
        XCTAssertTrue(result.first is SuccessPayload.Type)
    }

    func test_collection_accepted() {
        let sut: [Payload.Type] = [SuccessPayload.self, AcceptedPayload.self]
        let result = sut.filter(for: HTTPURLResponse(statusCode: 202))
        XCTAssertTrue(result.first is AcceptedPayload.Type)
    }

}
