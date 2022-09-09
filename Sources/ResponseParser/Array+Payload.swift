import Foundation

public extension Collection where Element == Payload.Type {
    func filter(for response: HTTPURLResponse) -> [Element] {
        filter { $0.satisfied(by: response) }
    }
}
