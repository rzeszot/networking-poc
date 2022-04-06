import Foundation

public protocol PayloadDecoder {
    var userInfo: [CodingUserInfoKey: Any] { get nonmutating set }
    func decode<T: Decodable>(_ type: T.Type, from: Data) throws -> T
}

extension JSONDecoder: PayloadDecoder {

}

extension PropertyListDecoder: PayloadDecoder {

}
