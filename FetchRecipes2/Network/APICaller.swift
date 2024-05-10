//
//  APICaller.swift
//  FetchRecipes2
//
//  Created by Omar Hegazy on 5/7/24.
//

import Foundation

// Protocol to define the properties of an API resource
protocol APIResource {
    var scheme: String { get }   // URL scheme
    var path: String { get }     // Path to the resource
    var host: String { get }     // API hostname
}

// Implementation of APIResource properties
extension APIResource {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "themealdb.com"
    }
}

// Paths to api, used for fetching recipes
enum Paths: String {
    case lookup = "lookup.php?i="
    case filter = "filter.php?c="
}

// Error handlers
enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}

struct Network: Networking {}

// Defines networking behavior for fetching data
protocol Networking {
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void)
}

extension Networking {
    // MARK: - Recipe data fetcher
    func fetch<T: Decodable>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void) {
        
        // Constructs the URL from endpoint properties
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        
        guard let urlString = urlComponents.url?.description else {
            preconditionFailure("Url is not valid")
        }
        
        guard let url = URL(string: urlString.removingPercentEncoding!) else {
            preconditionFailure("Url is not valid")
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ =  error {
                completion(.failure(.unableToComplete))
                return
            }
            
            // Check if the response returns status code 200, which indicates validity
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // Parses data based on endpoint type (lookup vs. other endpoints)
            if endpoint.path.contains("lookup") {
                do {
                    // Parses the JSON data using the formatResponse function from RecipeCard.swift
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    guard let json = json else {
                        preconditionFailure("JSON is not valid")
                    }
                    completion(.success(formatResponse(unparsedData: json) as! T))
                } catch {
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                }
            } else {
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    completion(.success(decodedResponse))
                } catch {
                    print(String(describing: error))
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
}

// API for Dessert category
struct DessertAPI {
    static var dessertAPI = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
}

class ApiCaller {
    // MARK: - Desserts Data Fetcher
    static func fetchDesserts(completion: @escaping(MealsResponse?, Error?) -> Void) {
        guard let url = URL(string: DessertAPI.dessertAPI) else { return }
        
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
