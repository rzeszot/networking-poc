import Networking

struct TeapodPayload: PayloadByStatusCode, Encodable, Error {
    static let code = 418

    let temperature: Int
}

typealias SignedTeapodPayload = SignedPayload<TeapodPayload>
