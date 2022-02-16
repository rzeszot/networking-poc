import Foundation

public protocol Payload: Decodable {
    static func satisfied(by response: Response) throws -> Bool
}

extension Payload {
    public func `throw`() throws -> Self {
        if let error = self as? Error {
            throw error
        }
            
        return self
    }
    
    public func cast<T: Payload>(as: T.Type) throws -> T {
        guard let payload = self as? T else {
            throw UnexpectedPayloadError(payload: self)
        }

        return payload
    }
}
