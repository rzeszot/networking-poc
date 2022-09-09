//import XCTest
//import ResponseParser
//
//final class PayloadTests: XCTestCase {
//
//    func test_throw_pass() {
//        let sut = SuccessPayload(number: 42)
//
//        XCTAssertFalse(sut is Error)
//        XCTAssertNoThrow(try sut.throw())
//    }
//
//    func test_throw_throws()  {
//        let sut: Payload & Error = BadRequestPayload()
//
//        XCTAssertThrowsError(try sut.throw()) { error in
//            XCTAssertTrue(error is BadRequestPayload)
//        }
//    }
//
//    func test_cast_pass() {
//        let sut = SuccessPayload(number: 42)
//
//        XCTAssertNoThrow(try sut.cast(as: SuccessPayload.self))
//    }
//
//    func test_cast_throws() {
//        let sut = SuccessPayload(number: 42)
//
//        XCTAssertThrowsError(try sut.cast(as: AcceptedPayload.self)) { error in
//            XCTAssertTrue(error is UnexpectedPayloadError)
//        }
//    }
//
//}
