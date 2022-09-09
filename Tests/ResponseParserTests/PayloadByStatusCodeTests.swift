import XCTest
import ResponseParser

final class PayloadByStatusCodeTests: XCTestCase {

    func test_status_code_accepted() {
        XCTAssertTrue(AcceptedPayload.satisfied(by: HTTPURLResponse(statusCode: 202)))
    }

    func test_status_code_succcess() {
        XCTAssertFalse(AcceptedPayload.satisfied(by: HTTPURLResponse(statusCode: 200)))
    }

}
