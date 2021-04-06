import XCTest
@testable import BreakingBad

final class NetworkTests : XCTestCase {

    private let api = API(scheme: "http", host: "domain.com")
    private let path = "/test/response"

    func testGET() throws {
        let request = Request<String>.get(at: path, output: .json)
        let urlRequest = try api.urlRequest(for: request)

        XCTAssertEqual(urlRequest.httpMethod, "GET")
        XCTAssertEqual(urlRequest.url?.absoluteString, "http://domain.com/test/response")
    }
}
