import SwiftUI

struct RecipeItem: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            
            Text(meal.strMeal)
        }
    }
}

#Preview {
    RecipeItem(meal: Meal(strMeal: "exampleMeal", strMealThumb: "https://picsum.photos/300/200", idMeal: "dsa"))
}
