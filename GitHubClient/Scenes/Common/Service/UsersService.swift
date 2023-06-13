import Foundation

protocol UsersServiceProtocol {
    func fetchUserList(endpoint: UsersEndpoint, completion: @escaping (Result<[UserModel], Error>) -> Void)
}

final class UsersService: UsersServiceProtocol {
    // MARK: - Properties
    var apiClient: APIClientProtocol
    
    // MARK: - Initialization
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Public Methods
    func fetchUserList(endpoint: UsersEndpoint, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        apiClient.request(endpoint: endpoint) {[unowned self] result in
            switch result {
            case .success(let data):
                do {
                    let userList = try decode(data, from: endpoint)
                    completion(.success(userList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func decode(_ data: Data, from endpoint: UsersEndpoint) throws -> [UserModel] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        if case .users = endpoint {
            return try decoder.decode([UserModel].self, from: data)
        } else {
            let user = try decoder.decode(UserModel.self, from: data)
            return [user]
        }
    }
}
