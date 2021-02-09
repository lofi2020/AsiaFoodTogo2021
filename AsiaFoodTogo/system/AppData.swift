//
//  AppData.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 04.02.21.
//

import Foundation

class AppData: ObservableObject  {

    @Published var store = Store()
    @Published var cart = Cart()
    @Published var cartTotal = "0,00€"
    @Published var cartItemCount = 0
    
    func apiLogin(completion: @escaping () -> Void) {
        let apiLoginPath = ServiceConfigurations.serverConfig.url + "route=" + ServiceConfigurations.apiLoginRoute
        let request = NSMutableURLRequest(url: URL(string: apiLoginPath)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let d = "user=\(ServiceConfigurations.serverConfig.user)&key=\(ServiceConfigurations.serverConfig.key)".data(using:String.Encoding.ascii, allowLossyConversion: false)
        request.httpBody = d
        URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            guard let data = data else {
                debugPrint("Fehler beim Laden", error ?? "Unbekannter Fehler")
                return
            }
            do {
                let store = try JSONDecoder().decode(Store.self, from: data)
                DispatchQueue.main.async {
                    self.store = store
                    completion()
                }
            } catch let error {
                   print("Fehler bei der Konvertierung: \(error)")
            }
        }.resume()
    }
    
    private static var sharedAppData: AppData = {
           let appData = AppData()
            appData.apiLogin {
                let dm = CartDataController()
                dm.loadCart()
            }
           return appData
    }()
    
    class func shared() -> AppData {
        return sharedAppData
    }
    
    func refreshCartTotal() {
        self.cartTotal = self.cart.totals.last!.text
        self.cartItemCount = self.cart.getItemCount()
    }

}
