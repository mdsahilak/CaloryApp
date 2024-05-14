//
//  NutritionService.swift
//  Calory
//
//  Created by Sahil Ak on 06/05/24.
//

import Foundation

final class NutritionService {
    private init() {  }
    
    static let baseURL = "https://api.api-ninjas.com/v1/nutrition"
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = ["X-Api-Key": "uW2zl9NIBuFcOOSMeMt5xQ==kaw7RwzzlIys8lTL"]
        
        return URLSession(configuration: config)
    }()
    
    // Get Information from nutrition API
    public static func fetchNutritionInfo(for name: String) async throws -> [NutritionInfo] {
        guard var components = URLComponents(string: Self.baseURL) else { throw APIError.invalidURL }
        components.queryItems = [URLQueryItem(name: "query", value: name)]
        
        guard let url = components.url else { throw APIError.invalidURL }
        
        let (data, _) = try await session.data(from: url)
        
        let decoder = JSONDecoder()
        let infos = try decoder.decode([NutritionInfo].self, from: data)
        print("DAPI response: \(infos)")
        return infos
    }
}

