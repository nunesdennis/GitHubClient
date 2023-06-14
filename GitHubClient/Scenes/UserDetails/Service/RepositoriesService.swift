import Foundation

protocol RepositoriesServiceProtocol {
    func fetchRepositoryList(from username: String, completion: @escaping (Result<[RepositoryModel], Error>) -> Void)
}

final class RepositoriesService: BaseService<RepositoryModel>, RepositoriesServiceProtocol {
    // MARK: - Methods
    func fetchRepositoryList(from username:String, completion: @escaping (Result<[RepositoryModel], Error>) -> Void) {
        fetchModelList(endpoint: UsersEndpoint.repos(username), completion: completion)
    }
}
