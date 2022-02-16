import Foundation
@testable import Networking

extension Response {
    static let shrug: Self = .init(status: 200, data: .shrug)
    static let success: Self = .init(status: 200, data: .number42)
    static let accepted: Self = .init(status: 202)
    static let badRequest: Self = .init(status: 400)
    static let gone: Self = .init(status: 410)
    
    static func teapod(signed: Bool? = nil) -> Self {
        var headers: [String: String] = [:]
        if let signed = signed {
            headers["signed"] = String(signed)
        }
        
        return .init(status: 418, headers: headers, data: .temperature)
    }
}

private extension Response {
    private init(status code: Int, headers: [String: String] = [:], data: Data = .empty) {
        let response = HTTPURLResponse(
            url: .example,
            statusCode: code,
            httpVersion: nil,
            headerFields: headers
        )
        self.init(response: response!, data: data)
    }
}

extension Data {
    static let empty = Data()
    
    static let number42: Data = """
        {
          "number" : 42
        }
        """.data(using: .utf8)!

    static let temperature: Data = """
        {
          "temperature" : 93
        }
        """.data(using: .utf8)!
    
    static let shrug: Data = """
        ¯\\_(ツ)_/¯
        """.data(using: .utf8)!
    
    static let plist: Data = """
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
        <plist version="1.0">
        <dict>
        \t<key>temperature</key>
        \t<integer>93</integer>
        </dict>
        </plist>\n
        """.data(using: .utf8)!
}
