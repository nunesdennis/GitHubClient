import Foundation

enum RequestError: Error {
    case api(error: Error)
    case noResponse
    case noData
    case noURL
    case lostReference
}

extension RequestError: Equatable {
    static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.api(error: let lhsError), .api(error: let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        case (.noResponse, .noResponse),
             (.noData, .noData),
             (.noURL, .noURL),
             (.lostReference, .lostReference):
            return true
        default:
            return false
        }
    }
}
