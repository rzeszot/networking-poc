import Foundation

struct Wrapper<T> {
    let links: T
}

extension Wrapper: Encodable where T: Encodable {

}

extension Wrapper: Decodable where T: Decodable {

}
