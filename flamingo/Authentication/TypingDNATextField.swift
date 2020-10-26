//
//  TypingDNATextField.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI
import RealityKit

/// Make text field that will respond to the **TypingDNA** Recorder
struct TypingDNATextField: UIViewRepresentable {
    /// The value of the text field. It may be used to clear the field when authentication fails.
    @Binding var text: String?
    
    /// If the text field shoul become first responder when initiliased.
    @Binding var shouldBecomeFirstResponder: Bool
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textField.textAlignment = .center
        textField.textColor = .white
        textField.layer.cornerRadius = 30.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.text = self.text
        
        if self.shouldBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
        
        TypingDNARecorderMobile.addTarget(textField)

        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = self.text
    }
}
