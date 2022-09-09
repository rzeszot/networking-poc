import ResponseParser

struct TeapodResponse: PayloadByStatusCode, Error {
    static let statusCode: Int = 418
}
