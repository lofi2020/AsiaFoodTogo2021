// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

import Foundation

// MARK: - Categories
class Categories: Codable {
    let categories: [Category]
    
    init() {
        self.categories = [Category]()
    }
    
    init(categories: [Category]) {
        self.categories = categories
    }
}

// MARK: - Category
class Category: Codable {
    let categoryID, name: String
    let thumb: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case name, thumb
    }

    init(categoryID: String, name: String, thumb: String) {
        self.categoryID = categoryID
        self.name = name
        self.thumb = thumb
    }
}

