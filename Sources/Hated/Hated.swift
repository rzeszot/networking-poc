import Foundation

public struct Hated<Object: Codable, Links: Codable>: Codable {
    public let object: Object
    public let links: Links

    public init(object: Object, links: Links) {
        self.object = object
        self.links = links
    }

    public init(from decoder: Decoder) throws {
        object = try Object.init(from: decoder)
        links = try Wrapper(from: decoder).links
    }

    public func encode(to encoder: Encoder) throws {
        try object.encode(to: encoder)
        try Wrapper(links: links).encode(to: encoder)
    }

    private struct Wrapper: Codable {
        let links: Links
    }
}
