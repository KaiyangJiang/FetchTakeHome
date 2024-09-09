import Foundation

class NetworkService {
    private let networkClient: NetworkClientProtocol

    // Singleton instance
    static let shared: NetworkService = {
        let defaultNetworkClient = NetworkClient() // Provide your default NetworkClient implementation
        return NetworkService(networkClient: defaultNetworkClient)
    }()

    // Private init to prevent creating new instances
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    // Method to fetch meals
    func fetchRecipe(url: String) async throws -> [Meal] {
        do {
            let response = try await networkClient.request(Meals.self, from: url)
            return response.meals
        } catch {
            print("Failed to load recipe: \(error.localizedDescription)")
            throw error
        }
    }

    // Method to fetch meal details
    func fetchRecipeDetail(url: String) async throws -> MealDetail? {
        do {
            let response = try await networkClient.request(MealDetailResponse.self, from: url)
            return response.meals.first
        } catch {
            print("Failed to load recipe: \(error.localizedDescription)")
            throw error
        }
    }
}
