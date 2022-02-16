import Foundation

public struct Parser: ExpressibleByArrayLiteral {
    public let payloads: [Payload.Type]
    public let decoder: PayloadDecoder

    public init(payloads: [Payload.Type], decoder: PayloadDecoder) {
      self.payloads = payloads
      self.decoder = decoder
    }
    
    public init(arrayLiteral elements: Payload.Type...) {
        self.init(payloads: elements, decoder: JSONDecoder.default)
    }

    // MARK: -

    public func payload(for request: Response) throws -> Payload.Type? {
        try payloads.first { payload in
            try payload.satisfied(by: request)
        }
    }
    
    public func parse(response: Response) throws -> Payload {
        guard let payload = try payload(for: response) else {
            throw PayloadNotFoundError(response: response.response)
        }

        return try decode(data: response.data, payload: payload)
    }

    // MARK: -

    private func decode(data: Data, payload: Payload.Type) throws -> Payload {
        decoder.userInfo[.payload] = payload
        return try decoder.decode(Wrapper.self, from: data).wrapped
    }

}

private struct Wrapper: Decodable {
    let wrapped: Payload

    init(from decoder: Decoder) throws {
        let payload = decoder.userInfo[.payload]! as! Payload.Type
        wrapped = try payload.init(from: decoder)
    }
}

private extension CodingUserInfoKey {
    static let payload = CodingUserInfoKey(rawValue: "Networking.payload")!
}
