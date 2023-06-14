import Foundation

enum RequestError: Error {
    case api(error: Error)
    case noResponse
    case noData
    case noURL
    case lostReference
}

protocol APIClientProtocol {
    func request(endpoint: EndpointProtocol, completion: @escaping (Result<Data, Error>) -> Void)
}

final class APIClient: APIClientProtocol {
    // MARK: - Properties
    
    let session: URLSession

    // MARK: - Initialization
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Private Methods
    
    private func makeRequest(_ endpoint: EndpointProtocol) -> URLRequest? {
        guard let url = endpoint.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        return request as URLRequest
    }
    
    // MARK: - Methods
    
    func request(endpoint: EndpointProtocol, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = makeRequest(endpoint) else {
            DispatchQueue.main.async {
                completion(.failure(RequestError.noURL))
            }
            return
        }

        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(RequestError.api(error: error)))
                    return
                }
                
                guard (response as? HTTPURLResponse) != nil else {
                    completion(.failure(RequestError.noResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(RequestError.noData))
                    return
                }
                
                completion(.success(data))
            }
        }.resume()
    }
}
