//
//  RecipeCardTest.swift
//  FetchRecipes2Tests
//
//  Created by Omar Hegazy on 5/10/24.
//

import XCTest
@testable import FetchRecipes2

final class RecipeCardTests: XCTestCase {
    
    // Mock Networking class for testing
    class MockNetworking: Networking {
        var shouldSucceed: Bool = true
        var mockRecipe: Recipe?
        var mockError: APIError?
        
        func fetch<T>(_ endpoint: APIResource, completion: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
            if shouldSucceed {
                if let recipe = mockRecipe as? T {
                    completion(.success(recipe))
                } else {
                    completion(.failure(.invalidData))
                }
            } else {
                if let error = mockError {
                    completion(.failure(error))
                } else {
                    completion(.failure(.unableToComplete))
                }
            }
        }
    }
    
    // Test case for successful recipe fetching
    func testFetchDetails_Success() {
        // Arrange
        let mockNetworking = MockNetworking()
        let recipeCard = RecipeCard(networking: mockNetworking)
        let mockRecipe = Recipe(name: "Mock Recipe", instructions: ["Instruction 1", "Instruction 2"], ingredients: ["Ingredient 1": "Quantity 1", "Ingredient 2": "Quantity 2"])
        mockNetworking.mockRecipe = mockRecipe
        
        let expectation = XCTestExpectation(description: "Fetch Recipe")
        var fetchedRecipe: Recipe?
        
        // Act
        recipeCard.fetchDetails(id: "1")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            fetchedRecipe = recipeCard.recipe
            expectation.fulfill()
        }
        
        // Assert
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(fetchedRecipe, mockRecipe)
    }
    
    
    // Test case for failed recipe fetching
    func testFetchDetails_Failure() {
        // Arrange
        let mockNetworking = MockNetworking()
        let recipeCard = RecipeCard(networking: mockNetworking)
        mockNetworking.shouldSucceed = false
        let expectedRecipe = Recipe(name: "Test", instructions: [""], ingredients: ["":""])
        
        // Act
        recipeCard.fetchDetails(id: "1")
        
        // Assert
        XCTAssertEqual(recipeCard.recipe, expectedRecipe)
    }
}
