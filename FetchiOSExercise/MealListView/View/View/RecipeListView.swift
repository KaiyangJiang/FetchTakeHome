import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel = MealsViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.meals){ meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal, viewModel: viewModel)){
                    RecipeItem(meal: meal)
                }
            }.navigationTitle("Recipes")
        }
        .task{
            await viewModel.fetchMeals()
        }
        
        // Show an alert when the errorMessage is not nil
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? "Unknown Error"),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
}

#Preview {
    let dataManager = DataManager()
    let mealViewModel = MealsViewModel()
    return RecipeListView(viewModel: mealViewModel)
}

