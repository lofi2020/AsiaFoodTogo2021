//
//  DataController.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 17.12.20.
//

import Foundation

class CartDataController: ObservableObject  {
    
    var appData = AppData.shared()
           
    func addToCart(product_id: String, quantity: Int = 1, completion: @escaping (ResponseDTO) -> Void) {
        let parameters = ["route" : ServiceConfigurations.addToCartRoute]
        let body = ["product_id": product_id, "quantity": "\(quantity)"]
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.POST,
                                                    parameters: parameters, body: body)
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let message = try JSONDecoder().decode(ResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(message)
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
        }.resume()
    }
        
    func loadCart() {
        let parameters = ["route" : ServiceConfigurations.cartProdutcsRoute]
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.GET,
                                                    parameters: parameters)
        URLSession.shared.dataTask(with: request) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            DispatchQueue.main.async {
                self.appData.cart = try! JSONDecoder().decode(Cart.self, from: data)
                self.appData.refreshCartTotal()
            }
        }.resume()
    }
    
    func editCart(key: String, quantity: Int, completion: @escaping (ResponseDTO) -> Void) {
        let parameters = ["route" : ServiceConfigurations.editCartRoute]
        let body = ["key": key, "quantity": "\(quantity)"]
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.POST,
                                                    parameters: parameters, body: body)
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let message = try JSONDecoder().decode(ResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(message)
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
        }.resume()
    }
    
    func removeCart(key: String,completion: @escaping (ResponseDTO) -> Void) {
        let parameters = ["route" : ServiceConfigurations.removeCartRoute]
        let body = ["key": key]
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.POST,                                     parameters: parameters, body: body)
        URLSession.shared.dataTask(with: request) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let message = try JSONDecoder().decode(ResponseDTO.self, from: data)
                DispatchQueue.main.async {
                    completion(message)
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
        }.resume()
    }

}




