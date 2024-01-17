//
//  HomeViewModel.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import Foundation
import Combine
import OSLog

class HomeViewModel : NSObject {
    @Published var articleData: [ArticlesData] = []
    
    override init() {
        super.init()
        getArticleData()
    }
    
    // MARK: Article Data Fetching
    /// Fetches article data from a local JSON file using a utility method.
    func getArticleData() {
        let data = Utils.fetchDataFromLocalJson(name: "Articles")
        do {
            if let data {
                let responseModel = try JSONDecoder().decode(Articles.self, from: data)
                self.articleData = responseModel.articlesData
            }
        } catch {
            // Handles parsing errors and logs a message using os_log
            self.articleData = []
            os_log("Parsing Error", log: OSLog.default, type: .error)
        }
    }
}
