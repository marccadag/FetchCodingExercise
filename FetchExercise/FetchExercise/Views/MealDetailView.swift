//
//  MealDetailView.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/23/24.
//

import Foundation
import SwiftUI

// MARK: -Meal Detail View
struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.mealDetail != nil {
                    mealImageView
                    mealNameView
                    instructionsView
                    ingredientsView
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .navigationTitle("Meal Detail")
        .task {
            await viewModel.loadMealDetail(id: mealId)
        }
        .alert("Error", isPresented: $viewModel.isShowingError){
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    // MARK: - Meal Image View
    private var mealImageView: some View {
        AsyncImage(url: URL(string: viewModel.mealDetail?.thumbnailURL ?? "")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
        .frame(height: 200)
    }
    
    // MARK: - Meal Name View
    private var mealNameView: some View {
        Text(viewModel.mealDetail?.name ?? "")
            .font(.title)
    }
    
    // MARK: - Instructions View
    private var instructionsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Instructions")
                .font(.headline)
            Text(viewModel.mealDetail?.instructions ?? "")
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    // MARK: - Ingredients View
    private var ingredientsView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.headline)
            if let mealDetail = viewModel.mealDetail {
                ForEach(mealDetail.ingredients) { ingredient in
                    Text("\(ingredient.name): \(ingredient.measurement)")
                }
            }
        }
    }
}
