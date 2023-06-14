import UIKit

protocol UsersViewModelProtocol {
    var okButtonTitle: String { get }
    var errorAlertTitle: String { get }
    var navigationTitle: String { get }
    func loadUsers(with username: String?, completion: @escaping (Result<[CardViewModel], Error>) -> Void)
    func openDetails(of user: UserModel)
}

final class UsersViewModel {
    // MARK: - Constants
    
    var errorAlertTitle: String { Localized("General.Alert.title") }
    var okButtonTitle: String { Localized("General.Alert.Button.title") }
    var navigationTitle: String { Localized("Users.Navigation.title") }
    
    // MARK: - Properties
    
    let coordinator: UsersCoordinatorProtocol
    let service: UsersServiceProtocol
    
    // MARK: - Initialization
    
    init(service: UsersServiceProtocol,
         coordinator: UsersCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
    
    // MARK: - Private Methods
    
    private func Localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    private func createCellViewModels(models: [UserModel]) -> [CardViewModel] {
        return models.compactMap { model in
            CardViewModel(user: model)
        }
    }
}

extension UsersViewModel: UsersViewModelProtocol {
    // MARK: - Methods
    
    func openDetails(of user: UserModel) {
        coordinator.goTo(user)
    }
    
    func loadUsers(with username: String? = nil, completion: @escaping (Result<[CardViewModel], Error>) -> Void) {
        guard let username = username else {
            loadUsers(completion: completion)
            return
        }
        
        loadUser(with: username, completion: completion)
    }
    
    private func loadUser(with username: String, completion: @escaping (Result<[CardViewModel], Error>) -> Void) {
        service.fetchUser(username) { [unowned self] result in
            switch result {
            case .success(let user):
                let cellViewModels = createCellViewModels(models: [user])
                completion(.success(cellViewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func loadUsers(completion: @escaping (Result<[CardViewModel], Error>) -> Void) {
        service.fetchUserList { [unowned self] result in
            switch result {
            case .success(let users):
                let cellViewModels = createCellViewModels(models: users)
                completion(.success(cellViewModels))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

