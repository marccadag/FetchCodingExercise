//
//  NetworkClient.swift
//  FetchExercise
//
//  Created by Marc Cadag on 7/28/24.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchResponse<T: Decodable>(endpoint: String) async throws -> T
}

enum NetworkClientError: Error {
    case missingURL
}

class NetworkClient: NetworkClientProtocol {
    static let shared = NetworkClient()
    
    private let baseURL = "https://themealdb.com/api/json/v1/1/"
    
    func fetchResponse<T>(endpoint: String) async throws -> T where T : Decodable {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkClientError.missingURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(T.self, from: data)
        
        return response
    }
}
