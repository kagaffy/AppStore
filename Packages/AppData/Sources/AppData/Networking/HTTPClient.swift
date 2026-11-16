import Foundation

public protocol HTTPClient: AnyObject {
    func data(from url: URL) async throws -> Data
}

public enum HTTPClientError: Error, Equatable {
    case invalidResponse
    case statusCode(Int)
}

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func data(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        guard let http = response as? HTTPURLResponse else {
            throw HTTPClientError.invalidResponse
        }
        guard (200 ..< 300).contains(http.statusCode) else {
            throw HTTPClientError.statusCode(http.statusCode)
        }
        return data
    }
}
