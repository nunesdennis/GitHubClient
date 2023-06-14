import Foundation

protocol UsersServiceProtocol {
    func fetchUser(_ username: String, completion: @escaping (Result<UserModel, Error>) -> Void)
    func fetchUserList(completion: @escaping (Result<[UserModel], Error>) -> Void)
}

final class UsersService: BaseService<UserModel>, UsersServiceProtocol {
    // MARK: - Methods
    func fetchUser(_ username: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        fetchModel(endpoint: UsersEndpoint.user(username), completion: completion)
    }
    
    func fetchUserList(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        fetchModelList(endpoint: UsersEndpoint.users, completion: completion)
    }
}
