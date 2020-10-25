//
//  View+Extension.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 25/10/2020.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
