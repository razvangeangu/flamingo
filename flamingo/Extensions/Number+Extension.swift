//
//  Float+Extension.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 25/10/2020.
//

import Foundation

extension Float {
    var currencyFormat: String {
        get {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = self.truncatingRemainder(dividingBy: 1) != 0 ? 2 : 0
            if let formattedTipAmount = formatter.string(from: NSNumber(value: self)) {
                return "\(formattedTipAmount)"
            }
            
            return "\(self)"
        }
    }
}

extension Double {
    var currencyFormat: String {
        get {
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = self.truncatingRemainder(dividingBy: 1) != 0 ? 2 : 0
            if let formattedTipAmount = formatter.string(from: NSNumber(value: self)) {
                return "\(formattedTipAmount)"
            }
            
            return "\(self)"
        }
    }
}
