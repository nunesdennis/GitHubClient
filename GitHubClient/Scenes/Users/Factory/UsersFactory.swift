import Foundation

struct UsersFactory {
    static func make(coordinator: UsersCoordinatorProtocol) -> UsersViewControllerProtocol {
        let service = UsersService()
        let viewModel = UsersViewModel(service: service, coordinator: coordinator)
        let controller = UsersViewController(viewModel: viewModel)

        return controller
    }
}
