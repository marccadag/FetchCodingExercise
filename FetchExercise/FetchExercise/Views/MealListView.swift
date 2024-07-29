//
//  MealListView.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/23/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealsViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                    MealRowView(meal: meal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.loadMeals()
            }
            .alert("Error", isPresented: $viewModel.isShowingError) {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
}

// MARK: - Meal Row View
struct MealRowView: View {
    let meal: Meal
    
    var body: some View {
        HStack {
            MealImageView(urlString: meal.thumbnailURL)
            Text(meal.name)
        }
    }
}

// MARK: - Meal Image View
struct MealImageView: View {
    let urlString: String
    
    var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(width: 50, height: 50)
        .cornerRadius(8)
    }
}
