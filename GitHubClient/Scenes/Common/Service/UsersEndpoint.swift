import Foundation

enum UsersEndpoint: EndpointProtocol {
    case users
    case user(String)
    
    // MARK: - Properties
    
    var endpoint: String {
        var endpoint = String()
        
        switch self {
        case .users:
            endpoint = "/users"
        case .user(let username):
            endpoint = "/users/\(username)"
        }
        
        return endpoint
    }
}
