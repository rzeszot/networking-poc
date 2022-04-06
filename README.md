# ResponseParser

Note that it's not for RESTful APIs.

```swift
struct TeapodService {
    let session: Session
    let parser: Parser = [
        TemperaturePayload.self,
        TeapodResponse.self
    ]
    
    // MARK: - Success
    
    struct TemperaturePayload: PayloadByStatusCode {
        static let code = 200
        let temperature: Double 
    }
    
    // MARK: - Failure
    
    struct TeapodResponse: PayloadByStatusCode, Error {
        static let code = 418
    }
    
    // MARK: -
    
    func temperature() async throws -> Double {
        let payload = try await session.execure(request: .teapod)
            .unpack(using: parser) // try to decode as `Payload` or throw `PayloadNotFoundError`
            .throw() // if it's `TeapodResponse`, throw it
            .cast(as: TemperaturePayload.self) // cast to `TemperaturePayload` or throw `UnexpectedPayloadError`
            
        return payload.temperature
    }

}

private extension URLRequest {
    static let teapod: Self = "https://teapod/"
}
```
