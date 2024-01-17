//
//  ModernAgingProjectUITests.swift
//  ModernAgingProjectUITests
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import XCTest
@testable import ModernAgingProject

class HomeViewControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }
    func testArticleCellExists() {
        // Ensure that there is at least one cell in the table view
        let cell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists, "Article cell not found")
    }
    
    func testReadMoreButton() {
        // Read More button on the first article cell
        let readMoreButton = app.buttons["Read More"]
        print(app.buttons)
        XCTAssertTrue(readMoreButton.exists, "Read More button not found")
      }
    
    func testTableViewIsVisible() {
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "Table view not found")
        XCTAssertTrue(tableView.isHittable, "Table view is not visible")
        
        let firstCell = tableView.cells.firstMatch
        XCTAssertTrue(firstCell.exists, "First cell not found")
      }
    
    func testCellConfiguration() {
          let tableView = app.tables.firstMatch
          XCTAssertTrue(tableView.exists, "Table view not found")

          let cell = tableView.cells.firstMatch
          XCTAssertTrue(cell.exists, "Article cell not found")
        
          //Ensure like and read button on cells.
          let likeButton = cell.buttons["like"]
          XCTAssertTrue(likeButton.exists, "Like button not found")
   
          let readMoreButton = cell.buttons["Read More"]
          XCTAssertTrue(readMoreButton.exists, "Read More button not found")

          // Tap on the "Read More" button
          readMoreButton.tap()

          // Toggle the "Like" button
          likeButton.tap()
      }

    func testStaticLabels() {
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "Table view not found")

        let cell = tableView.cells.firstMatch
        XCTAssertTrue(cell.exists, "Article cell not found")

        // Ensure static labels are found
        let emotionalLabel = cell.staticTexts["Emotional"]
        XCTAssertTrue(emotionalLabel.exists, "Emotional label not found")
      
        let physicalLabel = cell.staticTexts["Physical"]
        XCTAssertTrue(physicalLabel.exists, "Emotional label not found")
        
        let categoryLabel = cell.staticTexts["Categories"]
        XCTAssertTrue(categoryLabel.exists, "Categories label not found")
    }
    
   override func tearDown() {
        super.tearDown()
    }
}
