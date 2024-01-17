//
//  ArticlesTests.swift
//  ModernAgingProjectTests
//
//  Created by SONAM NARWARIYA on 17/01/24.
//

import XCTest
@testable import ModernAgingProject

final class ArticlesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeValidJSON() throws {
           // Given
           let json = """
           {
               "status": "success",
               "articlesData": [
                   {
                       "id": 1,
                       "headline": "Test Article",
                       "link": "https://example.com/test",
                       "photo": "test.jpg",
                       "categories": [
                           {"id": 101, "name": "Technology"},
                           {"id": 102, "name": "Science"}
                       ]
                   }
               ]
           }
           """
           
           // When
           let data = Data(json.utf8)
           let articles = try JSONDecoder().decode(Articles.self, from: data)
           
           // Then
           XCTAssertEqual(articles.status, "success")
           XCTAssertEqual(articles.articlesData.count, 1)
           XCTAssertEqual(articles.articlesData[0].id, 1)
           XCTAssertEqual(articles.articlesData[0].headline, "Test Article")
           XCTAssertEqual(articles.articlesData[0].link, "https://example.com/test")
           XCTAssertEqual(articles.articlesData[0].photo, "test.jpg")
           XCTAssertEqual(articles.articlesData[0].categories?.count, 2)
           XCTAssertEqual(articles.articlesData[0].categories?[0].id, 101)
           XCTAssertEqual(articles.articlesData[0].categories?[0].name, "Technology")
           XCTAssertEqual(articles.articlesData[0].categories?[1].id, 102)
           XCTAssertEqual(articles.articlesData[0].categories?[1].name, "Science")
       }

       func testDecodeInvalidJSON() throws {
           // Given
           let invalidJSON = """
           {
               "status": "success",
               "articlesData": [
                   {
                       "id": "invalid", // id should be an integer
                       "headline": "Test Article",
                       "link": "https://example.com/test",
                       "photo": "test.jpg",
                       "categories": [
                           {"id": 101, "name": "Technology"},
                           {"id": 102, "name": "Science"}
                       ]
                   }
               ]
           }
           """
           
           // When
           let data = Data(invalidJSON.utf8)
           
           // Then
           XCTAssertThrowsError(try JSONDecoder().decode(Articles.self, from: data))
       }

       func testDecodeMissingValues() throws {
           // Given
           let jsonWithMissingValues = """
           {
               "status": "success",
               "articlesData": [
                   {
                       "id": 1,
                       "headline": "Test Article"
                   }
               ]
           }
           """
           
           // When
           let data = Data(jsonWithMissingValues.utf8)
           let articles = try JSONDecoder().decode(Articles.self, from: data)
           
           // Then
           XCTAssertEqual(articles.status, "success")
           XCTAssertEqual(articles.articlesData.count, 1)
           XCTAssertEqual(articles.articlesData[0].id, 1)
           XCTAssertEqual(articles.articlesData[0].headline, "Test Article")
           XCTAssertNil(articles.articlesData[0].link)
           XCTAssertNil(articles.articlesData[0].photo)
           XCTAssertNil(articles.articlesData[0].categories)
       }
}
