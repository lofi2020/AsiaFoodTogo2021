import UIKit

enum HttpMethod: String {
    case GET
    case POST
    case UPDATE
    case DELETE
}

class HttpRequestBuilder {

    static func getRequest(url: String, httpMethod: HttpMethod, parameters: [String: String] = [:], body: [String: String] = [:]) -> URLRequest {
        var paramsWithToken = parameters
        paramsWithToken["api_token"] = AppData.shared().store.apiToken
        var components = URLComponents(string: url)!
        components.queryItems = paramsWithToken.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url!)
        request.httpMethod = httpMethod.rawValue
        if (httpMethod == HttpMethod.POST) {
            request.httpBody = HttpRequestBuilder.getBodyString(params: body).data(using:String.Encoding.ascii, allowLossyConversion: false)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
            
    private static func getBodyString(params:[String:Any]) -> String {
        var data = [String]()
        for(key, value) in params {
            data.append(key + "=\(value)")
        }
        return data.map { String($0)}.joined(separator: "&")
    }

    
}
