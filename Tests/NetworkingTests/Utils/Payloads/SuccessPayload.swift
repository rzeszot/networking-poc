import Networking

struct SuccessPayload: PayloadByStatusCode {
    static let code = 200

    let number: Int
}
