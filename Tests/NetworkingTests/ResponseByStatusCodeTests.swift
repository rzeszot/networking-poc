import XCTest
import Networking

final class ResponseByStatusCodeTests: XCTestCase {

    func test_response_by_status_code_success() {
        XCTAssertTrue(TeapodPayload.satisfied(by: .teapod()))
    }

    func test_response_by_status_code_failure() {
        XCTAssertFalse(TeapodPayload.satisfied(by: .success))
    }

}
