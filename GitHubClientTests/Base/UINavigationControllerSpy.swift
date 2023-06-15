import UIKit
@testable import GitHubClient

final class UINavigationControllerSpy: UINavigationController {
    // MARK: - Push View Controller
    
    private (set) var pushViewControllerCount = 0
    var pushedViewController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCount += 1
        pushedViewController = viewController
    }
}
