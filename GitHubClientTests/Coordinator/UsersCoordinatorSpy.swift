import Foundation
@testable import GitHubClient

final class UsersCoordinatorSpy: UsersCoordinatorProtocol {
    // MARK: - Go to users
    
    private (set) var goToUsersCount = 0
    
    func goToUsers() {
        goToUsersCount += 1
    }
    
    // MARK: - Go to user
    
    private (set) var goToUserCount = 0
    
    func goTo(_ user: UserModel) {
        goToUserCount += 1
    }
}
