//
//  MealService.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/26/24.
//

import Foundation

// MARK: -Meal Service Protocol
protocol MealServiceProtocol {
    func fetchMeals() async throws -> [Meal]
    func fetchMealDetails(id: String) async throws -> MealDetail
}

// MARK: -Meal Service Error
enum MealServiceError: Error {
    case missDetails
}

// MARK: - Meal Service
class MealService: MealServiceProtocol {

    func fetchMeals() async throws -> [Meal] {
        let response: MealResponse = try await NetworkClient.shared.fetchResponse(endpoint: "filter.php?c=Dessert")
        
        return response.meals
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        let response: MealDetailResponse = try await NetworkClient.shared.fetchResponse(endpoint: "lookup.php?i=\(id)")
        
        guard let detail = response.meals.first else {
            throw MealServiceError.missDetails
        }
        
        return detail
    }
}
