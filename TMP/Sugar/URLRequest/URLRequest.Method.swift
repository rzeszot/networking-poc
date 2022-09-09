//import Foundation
//
//extension URLRequest {
//    public struct Method: ExpressibleByStringLiteral {
//        fileprivate let string: String
//
//        public init(_ string: String) {
//            self.string = string.uppercased()
//        }
//
//        public init(stringLiteral value: String) {
//            self.init(value)
//        }
//    }
//
//    public init(_ method: Method, _ url: URL) {
//        self.init(url: url)
//        httpMethod = method.string
//    }
//}
//
//extension URLRequest.Method {
//    /// The GET method requests a representation of the specified resource. Requests using GET should only retrieve data.
//    public static let get: Self = "get"
//
//    /// The HEAD method asks for a response identical to a GET request, but without the response body.
//    public static let head: Self = "head"
//
//    /// The POST method submits an entity to the specified resource, often causing a change in state or side effects on the server.
//    public static let post: Self = "post"
//
//    /// The PUT method replaces all current representations of the target resource with the request payload.
//    public static let put: Self = "put"
//
//    /// The PATCH method applies partial modifications to a resource.
//    public static let patch: Self = "patch"
//
//    /// The DELETE method deletes the specified resource.
//    public static let delete: Self = "delete"
//}
