//
//  CategoryCollectionViewTests.swift
//  ModernAgingProjectTests
//
//  Created by SONAM NARWARIYA on 17/01/24.
//

import XCTest
@testable import ModernAgingProject

class ArticleTableViewDataSourceTests: XCTestCase {

    var tableView: UITableView!
    var dataSource: ArticleTableViewDataSource<ArticleTableViewCell,ArticlesData>!

    override func setUp() {
        super.setUp()
        tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        let articles = MockData.articles
        print(articles)
        dataSource = ArticleTableViewDataSource(cellIdentifier: "ArticleTableViewCell", items: articles.articlesData) { cell, article in
        }
    }

    // MARK: - Test Cases

    func testNumberOfRowsInSection() {
        // When
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)

        // Then
        XCTAssertEqual(numberOfRows, dataSource.items.count, "Number of rows should match the number of items")
    }

    func testCellConfiguration() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell

        // When
        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)

        // Then
        XCTAssertNotNil(cell, "Cell should not be nil")
        XCTAssertTrue(cell.isKind(of: ArticleTableViewCell.self), "Cell should be of type ArticleTableViewCell")
        XCTAssertEqual(cell.reuseIdentifier, "ArticleTableViewCell", "Cell should have the correct reuse identifier")
    }

    func testCellReuseIdentifier() {
        // Given
        let indexPath = IndexPath(row: 0, section: 0)

        // When
        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath)

        // Then
        XCTAssertNotNil(cell, "Cell should not be nil")
        XCTAssertNotEqual(cell.reuseIdentifier, "ArticleCell", "Cell should have the correct reuse identifier")
    }
}

