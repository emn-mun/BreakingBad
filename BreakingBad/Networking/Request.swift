import Foundation

public struct Request<T> {
    public let method: Method
    public let path: String
    public let body: Data?
    public let output: Output<T>

    private init(method: Method, path: String, body: Data? = nil, output: Output<T>) {
        self.method = method
        self.path = path
        self.body = body
        self.output = output
    }

    public static func get(at path: String, output: Output<T>) -> Request<T> {
        return Request<T>(
            method: .get,
            path: path,
            output: output
        )
    }

    public func decode(_ data: Data) throws -> T {
        return try output.decode(data)
    }

}
