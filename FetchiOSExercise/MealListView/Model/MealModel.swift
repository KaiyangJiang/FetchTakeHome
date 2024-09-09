import Foundation

struct Meals: Codable{
    let meals: [Meal]
}

struct Meal: Codable,Identifiable{
    var id: String {idMeal}
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
