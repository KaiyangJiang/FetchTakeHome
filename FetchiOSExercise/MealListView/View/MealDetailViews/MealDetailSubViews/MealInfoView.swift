import SwiftUI

struct MealInfoView: View {
    let mealDetail: MealDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(mealDetail.strMeal)
                .titleStyle()
            
            HStack {
                Text(mealDetail.strCategory)
                    .padding(5)
                    .background(Color.blue)
                    .clipShape(Capsule())
                
                Text(mealDetail.strArea)
                    .padding(5)
                    .background(Color.green)
                    .clipShape(Capsule())
            }
            
            if let youtubeURL = mealDetail.strYoutube,
               let url = URL(string: youtubeURL) {
                Link("Watch on YouTube", destination: url)
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}
