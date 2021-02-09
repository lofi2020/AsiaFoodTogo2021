//
//  CategoryDataController.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 03.02.21.
//

import Foundation

class CategoryDataController: ObservableObject {
    
    @Published var allData = Categories()
            
    func loadCategories() {
        let parameters = ["route": ServiceConfigurations.categoryRoute]
        let request = HttpRequestBuilder.getRequest(url: ServiceConfigurations.serverConfig.url, httpMethod: HttpMethod.GET, parameters: parameters)
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            // Fehlerbehandlung für den Fall, das ein Fehler aufgetreten ist und data nicht gesetzt ist
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let categories = try JSONDecoder().decode(Categories.self, from: data)
                DispatchQueue.main.async {
                    self.allData = categories
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
        }.resume()
    }
}
