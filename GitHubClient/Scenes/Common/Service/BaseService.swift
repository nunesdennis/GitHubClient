import Foundation

class BaseService<Model: Decodable> {
    // MARK: - Properties
    var apiClient: APIClientProtocol
    
    // MARK: - Initialization
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    // MARK: - Methods
    func fetchModel(endpoint: EndpointProtocol, completion: @escaping (Result<Model, Error>) -> Void) {
        apiClient.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try decoder.decode(Model.self, from: data)
                    completion(.success(model))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchModelList(endpoint: EndpointProtocol, completion: @escaping (Result<[Model], Error>) -> Void) {
        apiClient.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let modelList = try decoder.decode([Model].self, from: data)
                    completion(.success(modelList))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
