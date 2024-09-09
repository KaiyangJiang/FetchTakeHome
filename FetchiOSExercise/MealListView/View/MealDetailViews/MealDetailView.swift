import SwiftUI

struct MealDetailView: View {
    var mealId: String
    @ObservedObject var viewModel: MealsViewModel
    @StateObject var detailViewModel: MealDetailViewModel
    
    init(mealId: String, viewModel: MealsViewModel) {
        self.mealId = mealId
        self.viewModel = viewModel
        _detailViewModel = StateObject(wrappedValue: MealDetailViewModel())
    }
    
    var body: some View {
        ScrollView {
            if let mealDetail = detailViewModel.mealDetail {
                VStack(alignment: .leading, spacing: 10) {
                    MealImageView(imageURL: mealDetail.strMealThumb)
                    MealInfoView(mealDetail: mealDetail)
                    Divider()
                    IngredientsView(ingredients: Array(mealDetail.ingredients))
                    InstructionsView(instructions: mealDetail.strInstructions)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await detailViewModel.fetchMealDetail(by: mealId)
        }
        .alert(isPresented: Binding<Bool>(
            // Show an alert when the errorMessage is not nil
            get: { detailViewModel.errorMessage != nil },
            set: { _ in detailViewModel.errorMessage = nil }
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
    // Create the view model and pass it the DataManager
    let viewModel = MealsViewModel()
    
    // Initialize the MealDetailView with mealId and viewModel
    return MealDetailView(mealId: "53049", viewModel: viewModel)
}

