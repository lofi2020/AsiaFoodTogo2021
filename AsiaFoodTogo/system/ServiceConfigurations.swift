//
//  ServiceConfigurations.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 02.02.21.
//

import UIKit

class ServiceConfigurations {
    
    static var serverConfig: ServerConfig = ServerConfig()
   
    static let productRoute = "api/product"

    static let productDetailRoute = "api/product/detail"

    static let categoryRoute = "api/category"
    
    static let addToCartRoute = "api/cart/add"
    
    static let removeCartRoute = "api/cart/remove"

    static let editCartRoute = "api/cart/edit"

    static let cartProdutcsRoute = "api/cart/products"
    
    static let apiLoginRoute = "api/login"

}

struct ServerConfig: Codable {
    var url: String = "http://asiafood-togo.de/index.php?"
    var user: String = "Default"
    var key: String =  "5eVZUnJvT2veILWCWR3Pc5s40NEkH2PuMlkaccrPS4RebEKyDHdCIJ2mtr6ZLBZENjZCYVwHQlpFN1TNVGvugskKBem8KsXm4lj07TaGwCUaNKDVqCqKH1SaQRDkqmhi4tR8c01WQClM618MfpYePkPBPCHiKaCgZFo3kIoG1WeDp28VWNKT7dhWQ6Lc7yQKOYjDXNKnlzUA3nDYRO6xC56XNbFQbsF6ACGJl6tOKzqcWPW72o4CnGOFIwqjsnFN"
}
