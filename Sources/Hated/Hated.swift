import Foundation

public struct Hated<Object, Links> {
    public let object: Object
    public let links: Links

    public init(object: Object, links: Links) {
        self.object = object
        self.links = links
    }

    struct Wrapper {
        let links: Links
    }
}


// MARK: - Decodable

extension Hated: Decodable where Object: Decodable, Links: Decodable {
    public init(from decoder: Decoder) throws {
        object = try Object.init(from: decoder)
        links = try Wrapper(from: decoder).links
    }
}

extension Hated.Wrapper: Decodable where Links: Decodable {}

// MARK: - Encodable

extension Hated: Encodable where Object: Encodable, Links: Encodable {
    public func encode(to encoder: Encoder) throws {
        try object.encode(to: encoder)
        try Wrapper(links: links).encode(to: encoder)
    }
}

extension Hated.Wrapper: Encodable where Links: Encodable {}
