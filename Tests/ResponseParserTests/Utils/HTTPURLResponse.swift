import Foundation

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: .example, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
