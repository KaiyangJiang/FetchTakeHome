import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T
}

class NetworkClient:NetworkClientProtocol {
    private let session: URLSession
    
    // Dependency injection via initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Generic function to make GET requests and decode JSON responses
    func request<T: Decodable>(_ type: T.Type, from urlString: String) async throws -> T {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            // Perform the network request
            let (data, response) = try await session.data(from: url)
            
            // Check if the response is valid (status code 200-299)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.responseDecodingFailed
            }
            
            // Try decoding the JSON response to the expected type
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            // Throw a more specific error if something goes wrong
            throw NetworkError.requestFailed
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case responseDecodingFailed
    case unknownError
}
