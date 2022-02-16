import Foundation

public protocol Session {
    func execute(request: URLRequest) async throws -> Response
}
