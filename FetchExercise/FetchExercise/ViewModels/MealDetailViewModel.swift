//
//  MealDetailViewModel.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/23/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isShowingError: Bool = false
    @Published var errorMessage: String?
    
    private let mealService: MealServiceProtocol = MealService()
    
    func loadMealDetail(id: String) async {
        isShowingError = false
        
        do {
            mealDetail = try await mealService.fetchMealDetails(id: id)
        }
        catch {
            isShowingError = true
            errorMessage = "Failed to fetch meal details: \(error.localizedDescription)"
        }
    }
}
