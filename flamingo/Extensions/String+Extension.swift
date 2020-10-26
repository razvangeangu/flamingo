//
//  String+Extension.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 24/10/2020.
//

import Foundation

enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        default:
            return ""
        }
    }
}
extension String {
    var creditCardFormat: String {
        get {
            let numberOnly = self.replacingOccurrences(of: "[^0-9]", with: "", options: [.regularExpression])
            
            var formatted = ""
            var formatted4 = ""
            for character in numberOnly {
                if formatted4.count == 4 {
                    formatted += formatted4 + " "
                    formatted4 = ""
                }
                formatted4.append(character)
            }
            
            formatted += formatted4
            
            return formatted
        }
    }
    
    func final(characters: Int) -> String {
        let index = self.index(self.endIndex, offsetBy: -characters)
        return String(self[index...])
    }
}
