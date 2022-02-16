import Foundation

extension URLRequest.Method {
    static let custom: Self = "custom"
}

extension URLRequest {
    static let example: Self = .init(.get, .example)
}
