//
//  ContentView.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var totalBalance: Float = 12345.0
    @State var password: String = ""
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(totalBalance: $totalBalance)
//                .overlay(Blur())
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                    let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, "12345", 0)
                    print(typingPattern)
                    // self.totalBalance = Float.random(in: 999...4999)
                }
//            Add a big label and a description of how to register to use TypingDNA for authentication when trying to get credit card banking details
//            TypingDNATextField()
//                .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
        })
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterialDark
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
