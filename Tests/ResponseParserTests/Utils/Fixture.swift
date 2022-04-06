import Foundation
@testable import ResponseParser

struct Fixture {
    static let number42 = (response: HTTPURLResponse(statusCode: 200), data: Data.number42)
    static let shrug = (response: HTTPURLResponse(statusCode: 200), data: Data.shrug)
    static let success = (response: HTTPURLResponse(statusCode: 200), data: Data.empty)
    static let accepted = (response: HTTPURLResponse(statusCode: 202), data: Data.empty)
    static let badRequest = (response: HTTPURLResponse(statusCode: 400), data: Data.empty)
    static let gone = (response: HTTPURLResponse(statusCode: 410), data: Data.empty)

    static func teapod(signed: Bool? = nil) -> (response: HTTPURLResponse, data: Data) {
        var headers: [String: String] = [:]
        if let signed = signed {
            headers["signed"] = String(signed)
        }

        return (response: HTTPURLResponse(statusCode: 418, headers: headers), data: Data.temperature)
    }

}

extension HTTPURLResponse {
    convenience init(statusCode: Int, headers: [String: String] = [:]) {
        self.init(url: .example, statusCode: statusCode, httpVersion: nil, headerFields: headers)!
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
