// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let store = try? newJSONDecoder().decode(Store.self, from: jsonData)

import Foundation

// MARK: - Store
class Store: Codable, ObservableObject {
    
    let name, logo, address, geocode, geocodeHl: String
    let telephone, fax, storeOpen, apiToken: String
    
    init() {
        self.name = ""
        self.logo = ""
        self.address = ""
        self.geocode = ""
        self.geocodeHl = ""
        self.telephone = ""
        self.fax = ""
        self.storeOpen = ""
        self.apiToken = ""
    }

    enum CodingKeys: String, CodingKey {
        case name, logo, address, geocode
        case geocodeHl = "geocode_hl"
        case telephone, fax
        case storeOpen = "open"
        case apiToken = "api_token"
    }

    init(name: String, logo: String, address: String, geocode: String, geocodeHl: String, telephone: String, fax: String, storeOpen: String, apiToken: String) {
        self.name = name
        self.logo = logo
        self.address = address
        self.geocode = geocode
        self.geocodeHl = geocodeHl
        self.telephone = telephone
        self.fax = fax
        self.storeOpen = storeOpen
        self.apiToken = apiToken
    }
}

