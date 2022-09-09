//import Foundation
//
//extension URLRequest {
//    public mutating func body<T: Encodable>(json: T, using encoder: JSONEncoder = .default) throws {
//        httpBody = try encoder.encode(json)
//        addValue("application/json", forHTTPHeaderField: "Content-Type")
//    }
//}
