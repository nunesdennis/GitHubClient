import Foundation
@testable import GitHubClient
import XCTest

final class UsersViewModelTests: XCTestCase {
    
    var service: UsersServiceSpy!
    var coordinator: UsersCoordinatorSpy!
    var sut: UsersViewModelProtocol!
    lazy var dummyCardView: CardViewModel = .init(user: dummyUser)
    lazy var dummyUser: UserModel = .init(id: 0,
                                     login: String(),
                                     avatarUrl: String())
    
    override func setUpWithError() throws {
        coordinator = UsersCoordinatorSpy()
        service = UsersServiceSpy()
        sut = UsersViewModel(service: service,
                             coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        service = nil
        sut = nil
    }

    func testLoadUsers_WithUsername_Success() {
        let userReceived = UserModel(id: 12,
                                     login: "username",
                                     avatarUrl: "url")
        service.userModelReceived = userReceived
        
        var responseResult: CardViewModel = dummyCardView
        sut.loadUsers(username: String()) { result in
            if case .success(let response) = result {
                responseResult = response[0]
            }
        }
        
        XCTAssertEqual(service.fetchUserCount, 1)
        XCTAssertEqual(userReceived, responseResult.user)
    }
    
    func testLoadUsers_WithUsername_Failed() {
        let errorReceived: RequestError = .noData
        service.errorReceived = errorReceived
        
        var errorResult: RequestError = .noResponse
        sut.loadUsers(username: String()) { result in
            if case .failure(let error) = result {
                if let errorResponse = error as? RequestError {
                    errorResult = errorResponse
                }
            }
        }
        
        XCTAssertEqual(service.fetchUserCount, 1)
        XCTAssertEqual(errorReceived, errorResult)
    }
    
    func testLoadUsers_WithoutUsername_Success() {
        let userReceived = UserModel(id: 12,
                                     login: "username",
                                     avatarUrl: "url")
        service.userModelListReceived = [userReceived]
        
        var responseResult: CardViewModel = dummyCardView
        sut.loadUsers(username: nil) { result in
            if case .success(let response) = result {
                responseResult = response[0]
            }
        }
        
        XCTAssertEqual(service.fetchUserListCount, 1)
        XCTAssertEqual(userReceived, responseResult.user)
    }
    
    func testLoadUsers_WithoutUsername_Failed() {
        let errorReceived: RequestError = .noData
        service.errorReceived = errorReceived
        
        var errorResult: RequestError = .noResponse
        sut.loadUsers(username: nil) { result in
            if case .failure(let error) = result {
                if let errorResponse = error as? RequestError {
                    errorResult = errorResponse
                }
            }
        }
        
        XCTAssertEqual(service.fetchUserListCount, 1)
        XCTAssertEqual(errorReceived, errorResult)
    }
    
    func testOpenDetails() {
        sut.openDetails(of: dummyUser)
        
        XCTAssertEqual(coordinator.goToUserCount, 1)
    }
}
