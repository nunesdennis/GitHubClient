import Foundation
@testable import GitHubClient
import XCTest

final class UserDetailsViewModelTests: XCTestCase {
    
    var service: RepositoriesServiceSpy!
    var coordinator: UsersCoordinatorSpy!
    var sut: UserDetailsViewModelProtocol!
    lazy var dummyRepository: RepositoryModel = .init(name: String(),
                                                      description: String())
    lazy var dummyUser: UserModel = .init(id: 0,
                                          login: String(),
                                          avatarUrl: String())
    
    override func setUpWithError() throws {
        coordinator = UsersCoordinatorSpy()
        service = RepositoriesServiceSpy()
        sut = UserDetailsViewModel(user: dummyUser,
                                   service: service,
                                   coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        coordinator = nil
        service = nil
        sut = nil
    }

    func testLoadRepositories_Success() {
        let repositoryReceived = RepositoryModel(name: "Repository",
                                                 description: "Repository description")
        service.repositoryModelListReceived = [repositoryReceived]
        
        var responseResult: RepositoryModel = dummyRepository
        sut.loadRepositories(username: String()) { result in
            if case .success(let response) = result {
                responseResult = response[0]
            }
        }
        
        XCTAssertEqual(service.fetchRepositoryListCount, 1)
        XCTAssertEqual(repositoryReceived, responseResult)
    }
    
    func testLoadRepositories_Failed() {
        let errorReceived: RequestError = .noData
        service.errorReceived = errorReceived
        
        var errorResult: RequestError = .noResponse
        sut.loadRepositories(username: String()) { result in
            if case .failure(let error) = result {
                if let errorResponse = error as? RequestError {
                    errorResult = errorResponse
                }
            }
        }
        
        XCTAssertEqual(service.fetchRepositoryListCount, 1)
        XCTAssertEqual(errorReceived, errorResult)
    }
}
