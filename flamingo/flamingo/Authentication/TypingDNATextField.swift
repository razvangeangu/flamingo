//
//  TypingDNATextField.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

//import SwiftUI
//
//struct TypingDNATextField: View {
//    var body: some View {
//        TextField("Password", text: Binding.constant(""))
//            .keyboardType(.numberPad)
//            .border(Color.gray, width: 1)
//    }
//}
//
//#if DEBUG
//struct TypingDNATextField_Previews: PreviewProvider {
//    static var previews: some View {
//        TypingDNATextField()
//    }
//}
//#endif

import SwiftUI
import RealityKit

struct TypingDNATextField: UIViewRepresentable {
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.backgroundColor = .none
        textField.textAlignment = .center
        textField.borderStyle = .bezel
        
        TypingDNARecorderMobile.addTarget(textField)

        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
    }
}