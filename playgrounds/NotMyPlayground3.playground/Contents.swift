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


var id = "testuser"
let apiKey = "ce1475182ff875a47811ff880e6ee886"
let apiKeyEnc = "Y2UxNDc1MTgyZmY4NzVhNDc4MTFmZjg4MGU2ZWU4ODY="
let apiSecret = "dbd2ea1f330a50493fac3031e17a2055"
let apiSecretEnc = "ZGJkMmVhMWYzMzBhNTA0OTNmYWMzMDMxZTE3YTIwNTU="
let str = "Basic Y2UxNDc1MTgyZmY4NzVhNDc4MTFmZjg4MGU2ZWU4ODY6ZGJkMmVhMWYzMzBhNTA0OTNmYWMzMDMxZTE3YTIwNTU="
let testTp = "0, 2.11, 0, 0, 18, 1473785675, 4, 82, 13, 0, -1, -1, 0, -1, -1, 12, 93, 24, 0, -1, -1|8330, 137|1121, 142|902, 144|776, 128|792, 151|784, 111|864, 151|872, 111|824, 127|816, 104|888, 95|800, 151|808, 119|897, 134|775, 101|848, 111|1000, 143|688, 126"

func register(typingPattern: String) {
    
    
    let Url = String(format: "https://api.typingdna.com")
    let serviceUrl = URL(string: Url + "/save/" + String(id))
    let parameters: [String: Any] = [
//        "request": [
//            "id":"\(id)",
            "tp" : "\(testTp)",
//        ]
    ]
    var request = URLRequest(url: serviceUrl!)
    request.httpMethod = "POST"
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue(str, forHTTPHeaderField: "Authorization")
    let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    request.httpBody = httpBody
    request.timeoutInterval = 20
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        if let response = response {
            print(response)
        }
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }
    }.resume()
}
register(typingPattern: "")
