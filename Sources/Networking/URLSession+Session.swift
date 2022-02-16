import Foundation

extension URLSession: Session {
    public func execute(request: URLRequest) async throws -> Response {
        let (data, response) = try await data(for: request)
        return Response(response: response as! HTTPURLResponse, data: data)
    }
}
