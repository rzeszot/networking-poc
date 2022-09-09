import Foundation

public struct UnexpectedPayloadError: Error {
    public let payload: Payload
}
