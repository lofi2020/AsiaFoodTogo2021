//
//  DataController.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 17.12.20.
//

import Foundation

class ProductDataController: ObservableObject  {
    
    @Published var allData = Products()
    @Published var product = Product()
            
    func loadProducts(category_id: String = "0", search: String = "") {
        var parameters = ["route": ServiceConfigurations.productRoute]
        if (category_id != "0") {
            parameters["category_id"] = category_id
        }
        if (!search.isEmpty) {
            parameters["search"] = search
        }
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.GET, parameters: parameters)
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let products = try JSONDecoder().decode(Products.self, from: data)
                DispatchQueue.main.async {
                   self.allData = products
                }
            } catch let error {
                DispatchQueue.main.async {
                   self.allData = Products()
                   print("Fehler bei der Konvertierung: \(error)")
                }
            }
        }.resume()
    }
    
    func loadProduct(product_id: String, completion: @escaping () -> Void) {
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.GET, parameters: ["product_id": product_id, "route" : ServiceConfigurations.productDetailRoute])
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                DispatchQueue.main.async {
                    self.product = product
                    completion()
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
           
        }.resume()
    }
    
}




