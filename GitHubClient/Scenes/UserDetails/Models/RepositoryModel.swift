import Foundation

struct RepositoryModel: Decodable {
    let name: String
    let description: String?
}

extension RepositoryModel: Equatable {
    static func == (lhs: RepositoryModel, rhs: RepositoryModel) -> Bool {
        lhs.name == rhs.name &&
        lhs.description == rhs.description
    }
}
