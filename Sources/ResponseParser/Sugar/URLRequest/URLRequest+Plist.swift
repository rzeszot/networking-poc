import Foundation

extension URLRequest {
    public mutating func body<T: Encodable>(plist: T, using encoder: PropertyListEncoder = .default) throws {
        httpBody = try encoder.encode(plist)
        addValue("application/plist", forHTTPHeaderField: "Content-Type")
    }
}
