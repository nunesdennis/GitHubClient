import Foundation
@testable import GitHubClient

final class UsersServiceSpy: UsersServiceProtocol {
    // MARK: - Fetch user
    
    private (set) var fetchUserCount = 0
    var userModelReceived: UserModel?
    var errorReceived: RequestError = .noData
    
    func fetchUser(_ username: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        fetchUserCount += 1
        if let response = userModelReceived {
            completion(.success(response))
        } else {
            completion(.failure(errorReceived))
        }
    }
    
    // MARK: - Fetch user list
    
    private (set) var fetchUserListCount = 0
    var userModelListReceived: [UserModel]?
    
    func fetchUserList(completion: @escaping (Result<[UserModel], Error>) -> Void) {
        fetchUserListCount += 1
        if let response = userModelListReceived {
            completion(.success(response))
        } else {
            completion(.failure(errorReceived))
        }
    }
}
