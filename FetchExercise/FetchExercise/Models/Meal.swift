//
//  Meal.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/23/24.
//

// MARK: - Meal Model
struct Meal: Decodable, Identifiable {
    let id: String
    let name: String
    let thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}

// MARK: -Meal Response Model
struct MealResponse: Decodable {
    let meals: [Meal]
}



