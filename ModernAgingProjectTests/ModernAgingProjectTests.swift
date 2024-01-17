//
//  ModernAgingProjectTests.swift
//  ModernAgingProjectTests
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import XCTest
import Combine
@testable import ModernAgingProject

final class ModernAgingProjectTests: XCTestCase {
    
     var viewModel: HomeViewModel!
     var cancellables: Set<AnyCancellable> = []

     override func setUp() {
         super.setUp()
         viewModel = HomeViewModel()
     }

     // MARK: - Test Cases
     func testFetchArticleDataSuccess() {
         // Given
         let expectation = expectation(description: "Fetching article data successfully completes")

         // When
         viewModel.$articleData
             .sink { articleData in
                 // Then
                 XCTAssertFalse(articleData.isEmpty, "Article data should not be empty")
                 expectation.fulfill()
             }
             .store(in: &cancellables)

         // Wait for the expectation to be fulfilled
         waitForExpectations(timeout: 5, handler: nil)
     }
    
     func testMockedNetworkRequest() {
         // Given
         let expectation = expectation(description: "Mocked network request completes successfully")

         // When
         let mockData = try! JSONEncoder().encode(MockData.articles)
         Utils.stubData = mockData // Mock the network request by providing predefined data
         viewModel.getArticleData()

         viewModel.$articleData
             .sink { articleData in
                 // Then
                 XCTAssertEqual(articleData.count, MockData.articles.articlesData.count, "Article data should match the mocked data")
                 expectation.fulfill()
             }
             .store(in: &cancellables)

         // Wait for the expectation to be fulfilled
         waitForExpectations(timeout: 5, handler: nil)
     }
 }

 // Utility class for stubbing data
 class Utils {
     static var stubData: Data?

     static func fetchDataFromLocalJson(name: String) -> Data {
         // Check if stubbed data is available
         if let stubData = stubData {
             return stubData
         }

         // Otherwise, load data from the local JSON file
         let bundle = Bundle(for: Utils.self)
         let url = bundle.url(forResource: "Articles", withExtension: "json")!
         return try! Data(contentsOf: url)
     }
 }

 // Mock data for testing
 struct MockData {
     static let articles: Articles = {
         // Provide predefined data for testing
         let category1 = Category(id: 1, name: "Mock Category 1")
         let category2 = Category(id: 2, name: "Mock Category 2")

         let article1 = ArticlesData(id: 101, headline: "Mock Article 1", link: "https://example.com/mock1", photo: "mock1.jpg", categories: [category1])
         let article2 = ArticlesData(id: 102, headline: "Mock Article 2", link: "https://example.com/mock2", photo: "mock2.jpg", categories: [category2])

         return Articles(status: "success", articlesData: [article1, article2])
     }()
 }
