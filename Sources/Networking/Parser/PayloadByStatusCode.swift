import Foundation

public protocol PayloadByStatusCode: Payload {
    static var code: Int { get }
}

extension PayloadByStatusCode {
    public static func satisfied(by response: Response) -> Bool {
        response.code == code
    }
}
