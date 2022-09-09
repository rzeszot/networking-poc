import ResponseParser

struct BadRequestPayload: PayloadByStatusCode, Error {
    static let statusCode = 400
}
