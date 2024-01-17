//
//  Utils.swift
//  ModernAgingProject
//
//  Created by SONAM NARWARIYA on 15/01/24.
//

import Foundation
import UIKit

class Utils {
    static func fetchDataFromLocalJson(name: String)-> Data? {
        if let path = Bundle.main.path(forResource: name, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return (data)
            } catch {
            }
        }
        return nil
    }
}
