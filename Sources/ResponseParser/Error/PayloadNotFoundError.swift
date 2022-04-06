import Foundation

public struct PayloadNotFoundError: Error {
    public let response: HTTPURLResponse
}
