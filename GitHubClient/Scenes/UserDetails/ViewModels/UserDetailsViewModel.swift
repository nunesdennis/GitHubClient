import UIKit

protocol UserDetailsViewModelProtocol {
    var username: String { get }
    var okButtonTitle: String { get }
    var errorAlertTitle: String { get }
    var navigationTitle: String { get }
}

final class UserDetailsViewModel {
    // MARK: - Constants
    
    var errorAlertTitle: String { Localized("General.Alert.title") }
    var okButtonTitle: String { Localized("General.Alert.Button.title") }
    var navigationTitle: String { Localized("Users.Navigation.title") }
    
    // MARK: - Properties
    
    let coordinator: UsersCoordinatorProtocol
    let service: UsersServiceProtocol
    private (set) var user: UserModel
    var username: String {
        user.login
    }
    
    // MARK: - Initialization
    
    init(user: UserModel,
         service: UsersServiceProtocol,
         coordinator: UsersCoordinatorProtocol) {
        self.service = service
        self.coordinator = coordinator
        self.user = user
    }
    
    // MARK: - Private Methods
    
    private func Localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

extension UserDetailsViewModel: UserDetailsViewModelProtocol {}

