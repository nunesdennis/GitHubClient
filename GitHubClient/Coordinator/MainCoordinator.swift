import UIKit

final class MainCoordinator: CoordinatorProtocol {
    // MARK: - Properties
    var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: - Initialization
    required init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToMainViewController()
    }
    
    // MARK: - Main Scene
    
    private func goToMainViewController() {
        let coordinator = UsersCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

extension MainCoordinator: UsersCoordinatorDelegate {}
