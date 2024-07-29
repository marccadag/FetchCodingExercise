//
//  MealDetail.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/29/24.
//

import Foundation

struct MealDetail: Decodable, Identifiable {
    let id: String
    let name: String
    let instructions: String
    let thumbnailURL: String
    let ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
             strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
             strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
             strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
             strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
             strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
             strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnailURL = try container.decode(String.self, forKey: .thumbnailURL)
        
        ingredients = try (1...20).compactMap { index in
            guard let key = CodingKeys(rawValue: "strIngredient\(index)"),
                  let name = try container.decodeIfPresent(String.self, forKey: key),
                  !name.isEmpty
            else {
                return nil
            }
            
            guard let measurementKey = CodingKeys(rawValue: "strMeasure\(index)"),
                let measurement = try container.decodeIfPresent(String.self, forKey: measurementKey),
                  !measurement.isEmpty
            else {
                return nil
            }

            return Ingredient(name: name, measurement: measurement)
        }
    }
}

struct Ingredient: Identifiable {
    let id: UUID = UUID()
    let name: String
    let measurement: String
}

// MARK: -Meal Detail Response Model
struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}
