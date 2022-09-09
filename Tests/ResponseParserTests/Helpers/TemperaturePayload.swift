import ResponseParser

struct TemperaturePayload: PayloadByStatusCode {
    static let statusCode = 200

    let temperature: Double
}
