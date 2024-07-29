//
//  MealsViewModel.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/23/24.
//

import Foundation

@MainActor
class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isShowingError: Bool = false
    @Published var errorMessage: String?
    
    private let mealService: MealServiceProtocol = MealService()
    
    func loadMeals() async {
        isShowingError = false
        
        do {
            meals = try await mealService.fetchMeals().sorted { $0.name < $1.name }
        } catch {
            isShowingError = true
            errorMessage = "Failed to fetch meals: \(error.localizedDescription)"
        }
    }
}
