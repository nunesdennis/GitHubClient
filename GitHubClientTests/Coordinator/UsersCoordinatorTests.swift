import UIKit
@testable import GitHubClient
import XCTest

final class UsersCoordinatorTests: XCTestCase {
    
    var navigationController: UINavigationControllerSpy!
    var sut: UsersCoordinatorProtocol!
    lazy var dummyUser: UserModel = .init(id: 0,
                                     login: String(),
                                     avatarUrl: String())
    
    override func setUpWithError() throws {
        navigationController = UINavigationControllerSpy()
        sut = UsersCoordinator(navigationController: navigationController)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        sut = nil
    }
    
    func testGoToUsers() {
        sut.goToUsers()
        
        XCTAssert(navigationController.pushedViewController is UsersViewControllerProtocol)
        XCTAssertEqual(navigationController.pushViewControllerCount, 1)
    }
    
    func testGoToUser() {
        sut.goTo(dummyUser)
        
        XCTAssert(navigationController.pushedViewController is UserDetailsViewControllerProtocol)
        XCTAssertEqual(navigationController.pushViewControllerCount, 1)
    }
}
