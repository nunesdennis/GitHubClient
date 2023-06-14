import Foundation

struct UserDetailsFactory {
    static func make(user: UserModel, coordinator: UsersCoordinatorProtocol) -> UserDetailsViewControllerProtocol {
        let service = RepositoriesService()
        let viewModel = UserDetailsViewModel(user: user, service: service, coordinator: coordinator)
        let controller = UserDetailsViewController(viewModel: viewModel)

        return controller
    }
}
