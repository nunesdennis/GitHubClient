import Foundation
@testable import GitHubClient

final class UsersViewModelSpy: UsersViewModelProtocol {
    // MARK: - Constants
    
    var okButtonTitle: String = .init()
    var errorAlertTitle: String = .init()
    var navigationTitle: String = .init()
    
    // MARK: - Load Users
    
    private (set) var loadUsersCount = 0
    var cardViewModelListReceived: [CardViewModel]?
    var errorReceived: RequestError = .noData
    
    func loadUsers(username: String?, completion: @escaping (Result<[CardViewModel], Error>) -> Void) {
        loadUsersCount += 1
        if let response = cardViewModelListReceived {
            completion(.success(response))
        } else {
            completion(.failure(errorReceived))
        }
    }
    
    // MARK: - Open Details
    
    private (set) var openDetailsCount = 0
    
    func openDetails(of user: UserModel) {
        openDetailsCount += 1
    }
}
