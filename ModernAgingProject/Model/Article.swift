//
//  Article.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import Foundation

struct Articles: Codable{
    let status:String
    let articlesData:[ArticlesData]
}

struct ArticlesData: Codable {
    var id:Int?
    var headline,link: String?
    var photo: String?
    var categories:[Category]?
}

struct Category:Codable{
    var id:Int
    var name:String
}

