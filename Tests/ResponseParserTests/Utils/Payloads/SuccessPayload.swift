import ResponseParser

struct SuccessPayload: PayloadByStatusCode {
    static let statusCode = 200

    let number: Int
}
