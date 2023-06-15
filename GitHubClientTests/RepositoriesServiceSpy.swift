import Foundation
@testable import GitHubClient

final class RepositoriesServiceSpy: RepositoriesServiceProtocol {
    // MARK: - Fetch user
    
    private (set) var fetchRepositoryListCount = 0
    var repositoryModelListReceived: [RepositoryModel]?
    var errorReceived: RequestError = .noData
    
    func fetchRepositoryList(username: String, completion: @escaping (Result<[RepositoryModel], Error>) -> Void) {
        fetchRepositoryListCount += 1
        if let response = repositoryModelListReceived {
            completion(.success(response))
        } else {
            completion(.failure(errorReceived))
        }
    }
}
