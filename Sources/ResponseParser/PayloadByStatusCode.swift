import Foundation

public protocol PayloadByStatusCode: Payload {
    static var statusCode: Int { get }
}

extension PayloadByStatusCode {
    public static func satisfied(by response: HTTPURLResponse) -> Bool {
        response.statusCode == statusCode
    }
}
