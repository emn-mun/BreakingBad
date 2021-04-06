import Foundation

public struct API {

    public enum APIError: Swift.Error {
        case invalidURL(components: URLComponents)
    }

    public let scheme: String
    public let host: String

    public init(scheme: String, host: String) {
        self.scheme = scheme
        self.host = host
    }

    public func url<T>(for request: Request<T>) throws -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = request.path
        guard let url = components.url else {
            throw APIError.invalidURL(components: components)
        }
        return url
    }

    public func urlRequest<T>(for request: Request<T>) throws -> URLRequest {
        let url = try self.url(for: request)

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
    
        return urlRequest
    }
    
    public func result<T: Codable>(for request: Request<T>, completion: @escaping (Result<T, Error>) -> Void) throws {
        let req = try urlRequest(for: request)
        let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
            do {
                let model: T = try JSONDecoder().decode(T.self, from: data ?? Data())
                completion(.success(model))
                return
            } catch let error {
                completion(.failure(error))
                return
            }
        }
        task.resume()
    }
}
