//
//  RsponseMassage.swift
//  AsiaFoodTogo
//
//  Created by Lofi on 03.02.21.
//

import Foundation

class ResponseDTO : Codable  {
    var success: String? = nil
    var error: String? = nil
    var warning: String? = nil
    
    init() {
        self.success = ""
        self.error = ""
        self.warning = ""
    }
}
