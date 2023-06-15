import Foundation

struct UserModel: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String
}

extension UserModel: Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.id == rhs.id &&
        lhs.login == rhs.login &&
        lhs.avatarUrl == rhs.avatarUrl
    }
}
