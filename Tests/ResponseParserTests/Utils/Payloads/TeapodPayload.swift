import ResponseParser

struct TeapodPayload: PayloadByStatusCode, Encodable, Error {
    static let statusCode = 418

    let temperature: Int
}

typealias SignedTeapodPayload = SignedPayload<TeapodPayload>
