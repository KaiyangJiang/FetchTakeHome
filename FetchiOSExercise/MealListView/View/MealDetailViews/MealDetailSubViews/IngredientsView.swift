import SwiftUI

struct IngredientsView: View {
    let ingredients: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Ingredients")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(ingredients.indices, id: \.self) { index in
                Text("• \(ingredients[index])")
            }
        }
        .padding()
    }
}
