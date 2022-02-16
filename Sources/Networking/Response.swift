import Foundation

public struct Response {
    let response: HTTPURLResponse
    public let data: Data
    
    public var code: Int {
        response.statusCode
    }
    
    public subscript(_ key: String) -> String? {
        response.value(forHTTPHeaderField: key)
    }
}

extension Response {
    public func unpack(using parser: Parser) async throws -> Payload {
        try parser.parse(response: self)
    }
}
