import Foundation
import Networking

class SessionFake: Session {
    private var result: Result<Response, Error>!

    func succeeds(response: Response) {
        result = .success(response)
    }

    func fails(error: Error) {
        result = .failure(error)
    }

    // MARK: - Session

    func execute(request: URLRequest) async throws -> Response {
        switch result! {
        case let .success(response):
            return response
        case let .failure(error):
            throw error
        }
    }

}
