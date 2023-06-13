import UIKit

protocol CoordinatorProtocol: AnyObject {
    var parentCoordinator: CoordinatorProtocol? { get }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController? { get set }
    
    init(navigationController: UINavigationController?)
    
    func start()
}

extension CoordinatorProtocol {
    func childDidFinish(_ child: CoordinatorProtocol) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}
