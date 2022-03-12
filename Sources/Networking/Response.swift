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
    
    public var cookies: [String: String] {
        let pairs = self["Cookie"]?
            .components(separatedBy: "; ")
            .map { item in
                item
                    .split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
                    .map(String.init)
            }
            .compactMap { (pair: [String]) -> (String, String) in
                (pair[0], pair.count == 2 ? pair[1] : "")
            }
            ?? []
            
        return Dictionary(uniqueKeysWithValues: pairs)
    }

}

extension Response {
    public func unpack(using parser: Parser) async throws -> Payload {
        try parser.parse(response: self)
    }
}
