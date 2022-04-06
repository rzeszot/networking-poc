import Foundation
import ResponseParser

struct SignedPayload<T: Payload>: Payload {
    struct InvalidSignatureError: Error {

    }

    let payload: T

    init(from decoder: Decoder) throws {
        payload = try T(from: decoder)
    }

    static func satisfied(by response: HTTPURLResponse) throws -> Bool {
        guard let signature = response["signed"] else {
            return false
        }

        guard signature == String(true) else {
            throw InvalidSignatureError()
        }

        return try T.satisfied(by: response)
    }
}
