import Foundation

protocol EndpointProtocol {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: String { get }
    var header: [String: String] { get }
    var url: URL? { get }
}

extension EndpointProtocol {
    var baseURL: String {
        "https://api.github.com"
    }
    
    var method: String {
        "GET"
    }
    
    var header: [String: String] {
        [
            "accept": "application/json",
        ]
    }
    
    var url: URL? {
        let urlString = baseURL + endpoint
        return URL(string: urlString)
    }
}
