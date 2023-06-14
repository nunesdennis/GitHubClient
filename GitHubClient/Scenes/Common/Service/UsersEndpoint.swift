import Foundation

enum UsersEndpoint: EndpointProtocol {
    case users
    case user(String)
    case repos(String)
    
    // MARK: - Properties
    
    var endpoint: String {
        var endpoint = String()
        
        switch self {
        case .users:
            endpoint = "/users"
        case .user(let username):
            endpoint = "/users/\(username)"
        case .repos(let username):
            endpoint = "/users/\(username)/repos"
        }
        
        return endpoint
    }
}
