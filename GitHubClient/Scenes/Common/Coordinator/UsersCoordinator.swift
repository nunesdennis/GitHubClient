import UIKit

protocol UsersCoordinatorDelegate {}
protocol UsersCoordinatorProtocol {
    func goToUsers()
    func goTo(_ user: UserModel)
}

final class UsersCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    weak var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    weak var navigationController: UINavigationController?
    
    // MARK: - Initialization
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        goToUsers()
    }
}

extension UsersCoordinator: UsersCoordinatorProtocol {
    func goToUsers() {
        let viewController = UsersFactory.make(coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func goTo(_ user: UserModel) {
        let viewController = UserDetailsFactory.make(user: user, coordinator: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
