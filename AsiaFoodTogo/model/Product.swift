// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let products = try? newJSONDecoder().decode(Products.self, from: jsonData)

import Foundation

// MARK: - Products
class Products : Decodable {
    var products: [Product]
    init() {
        self.products = []
    }
}

// MARK: - Product
class Product : Decodable {
    var product_id: String
    var thumb: String
    var name, description, price: String
    var special, tax: Bool
    var minimum: String
    var rating: Int
    var href: String
    
    init() {
        self.product_id = ""
        self.thumb = ""
        self.name = ""
        self.description = ""
        self.price = ""
        self.special = false
        self.tax = false
        self.minimum = ""
        self.rating = 0
        self.href = ""
    }
    
    func getStars() -> String {
        var stars: String = ""
        for _ in 0...(rating) {
            stars = "\(stars)★"
        }
        return stars
    }
    
    func getTitle() -> String {
        return "\(product_id).\(name)"
    }
}
