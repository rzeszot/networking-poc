import Foundation

struct HTTPClient {
    private let response: Result<(Data, HTTPURLResponse), Error>

    private init(response: Result<(Data, HTTPURLResponse), Error>) {
        self.response = response
    }

    func execute(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        try response.get()
    }

    static func returning(data: Data, response: HTTPURLResponse) -> HTTPClient {
        .init(response: .success((data, response)))
    }

    static func throwing(error: Error, response: HTTPURLResponse) -> HTTPClient {
        .init(response: .failure(error))
    }
}
