import Foundation
import ResponseParser

struct TeapodService {
    let client: HTTPClient
    let payloads: [Payload.Type] = [TemperaturePayload.self, TeapodResponse.self]

    func temperature() async throws -> Double {
        let (data, response) = try await client.execute(request: URLRequest(url: URL(string: "https://example.org/endpoint")!))
        let decoder = JSONDecoder()

        let payload = payloads.filter(for: response).first!
        let object = try decoder.decode(payload, from: data)

        if let object = object as? TemperaturePayload {
            return object.temperature
        } else if object is TeapodResponse {
            return 100
        } else {
            throw UnexpectedPayloadError()
        }
    }

}
