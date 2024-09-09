import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String? = nil
    
    // Fetch all meals
    @MainActor
    func fetchMeals() async {
        do{
            meals = try await DataManager.shared.fetchMeals()
        }catch{
            errorMessage = "\(error.localizedDescription)"
            print("error fetchMeals: \(error)")
        }
    }
}




