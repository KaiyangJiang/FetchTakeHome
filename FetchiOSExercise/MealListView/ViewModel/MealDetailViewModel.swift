//
//  MealDetailViewModel.swift
//  FetchiOSExercise
//
//  Created by Kaiyang Jiang on 9/9/24.
//

import Foundation

class MealDetailViewModel:ObservableObject{
    @Published var mealDetail: MealDetail?
    @Published var errorMessage: String? = nil
    
    @MainActor
    func fetchMealDetail(by id: String) async {
        do{
            mealDetail = try await DataManager.shared.fetchMealDetail(id:id)
        }catch{
            errorMessage = "\(error.localizedDescription)"
            print("error fetchMealDetail: \(error)")
        }
    }
}
