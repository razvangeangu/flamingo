//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

//let url = URL(string: "https://api.chucknorris.io/jokes/random")
//let task = URLSession.shared.dataTask(with: url!) {
//    (data, response, error) in
//    guard let data = data else {return }
//    print(String(data: data, encoding: .utf8) ?? "")
//}
//task.resume()

let apiKey = "ce1475182ff875a47811ff880e6ee886"
let apiSecret = "dbd2ea1f330a50493fac3031e17a2055"
let apiAuthentication = "Basic \("\(apiKey):\(apiSecret)".data(using: .utf8)!.base64EncodedString())"
let testTp = "0, 2.11, 0, 0, 18, 1473785675, 4, 82, 13, 0, -1, -1, 0, -1, -1, 12, 93, 24, 0, -1, -1|8330, 137|1121, 142|902, 144|776, 128|792, 151|784, 111|864, 151|872, 111|824, 127|816, 104|888, 95|800, 151|808, 119|897, 134|775, 101|848, 111|1000, 143|688, 126"

struct APIResponse: Codable {
    var message: String
    var message_code: Int
    var status: Int
    var success: Int
}

private func initRequest(_ route: String) -> URLRequest {
    /// Set up request defaults
    var request = URLRequest(url: URL(string: "https://api.typingdna.com\(route)")!)
    request.httpMethod = "POST"
    request.setValue(apiAuthentication, forHTTPHeaderField: "Authorization")
    
    return request
}

func register(typingPattern: String, id: String) {
    var request = initRequest("/save/\(id)")
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    /// Set up data
    request.httpBody = "tp=\(typingPattern)".data(using: .utf8)
    
    /// Call for response
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
            // print(try? JSONSerialization.jsonObject(with: data, options: []))
            guard let model = try? JSONDecoder().decode(APIResponse.self, from: data) else { return }
            print(model)
        }
    }.resume()
}

//register(typingPattern: testTp, id: "")

func identify(typingPattern: String, id: String) -> Bool {
    var request = initRequest("/verify/\(id)")
    request.setValue("application/form-data", forHTTPHeaderField: "Content-Type")
    
    /// Set up data
    request.httpBody = "tp=\(typingPattern)&quality=1".data(using: .utf8)
    
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let data = data {
            print(try? JSONSerialization.jsonObject(with: data, options: []))
            // guard let model = try? JSONDecoder().decode(APIResponse.self, from: data) else { return }
            // print(model)
        }
    }.resume()
    return false
}

identify(typingPattern: testTp, id: "testuser")
