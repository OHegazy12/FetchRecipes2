//
//  APICaller.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import Foundation

struct Network {
    static var dessertAPI = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
}

class ApiCaller {
    
    // MARK: - Desserts Data Fetcher
    static func fetchDesserts(completion: @escaping(MealsResponse?, Error?) -> Void) {
        guard let url = URL(string: Network.dessertAPI) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                debugPrint("Error fetching data: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let meals = try JSONDecoder().decode(MealsResponse.self, from: data)
                completion(meals, nil)
            } catch {
                completion(nil, error)
            }
        }
        .resume()
    }
}
