import Foundation

public protocol Payload: Decodable {
    static func satisfied(by response: HTTPURLResponse) -> Bool
}
