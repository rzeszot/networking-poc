import Networking

struct BadRequestPayload: PayloadByStatusCode, Error {
    static let code = 400
}
