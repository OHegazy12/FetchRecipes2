//
//  APICallerTest.swift
//  FetchRecipes2Tests
//
//  Created by Omar Hegazy on 5/9/24.
//

import XCTest
import SwiftUI
@testable import FetchRecipes2

final class APICallerTest: XCTestCase {
    
    // MARK: - Test Fetch functions
    func testFetchDesserts() {
        let expectation = self.expectation(description: "Desserts fetched successfully")
        
        // Call the fetchDesserts method
        ApiCaller.fetchDesserts { mealsResponse, error in
            XCTAssertNotNil(mealsResponse, "Meals response should not be nil")
            XCTAssertNil(error, "Error should be nil")
            expectation.fulfill()
        }
        
        // Wait for the expectation to be fulfilled with a timeout
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // MARK: - UI Tests
    func testDessertViewLoading() {
        let view = DessertView()
        
        let hostingController = UIHostingController(rootView: view)
        _ = hostingController.view
        
        XCTAssertNotNil(view)
    }
    
}
