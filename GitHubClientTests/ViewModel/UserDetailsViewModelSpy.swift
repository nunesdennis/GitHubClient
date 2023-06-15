import Foundation
@testable import GitHubClient

final class UserDetailsViewModelSpy: UserDetailsViewModelProtocol {
    // MARK: - Constants
    
    var okButtonTitle: String = .init()
    var errorAlertTitle: String = .init()
    var navigationTitle: String = .init()
    
    // MARK: - Properties
    
    var user: UserModel = UserModel(id: 0, login: .init(), avatarUrl: .init())
    var username: String = .init()
    
    // MARK: - Load Repositories
    
    private (set) var loadRepositoriesCount = 0
    var repositoryListReceived: [RepositoryModel]?
    var errorReceived: RequestError = .noData
    
    func loadRepositories(username: String, completion: @escaping (Result<[RepositoryModel], Error>) -> Void) {
        loadRepositoriesCount += 1
        if let response = repositoryListReceived {
            completion(.success(response))
        } else {
            completion(.failure(errorReceived))
        }
    }
}
