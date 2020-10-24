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
    @State var cardNumber: String! = "alora"
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(totalBalance: $totalBalance)
                .onCardInfoReceived(perform: { (cardNumber) in
                    self.cardNumber = cardNumber
                })
                .overlay(self.cardNumber != nil ? Blur() : nil)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                    let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, "12345", 0)
                    print(typingPattern)
                    // self.totalBalance = Float.random(in: 999...4999)
                }
            if self.cardNumber != nil {
                VStack {
                    Text("Insert your card number to authenticate")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(Font.system(.title))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        .multilineTextAlignment(.center)
                    Text("1234 5678 9123 4567")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(Font.system(.title2))
                        .multilineTextAlignment(.center)
                    TypingDNATextField()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
                    Button("Apasă-mă") {
                        print("button pressed")
                    }
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                }
            }
        })
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemThinMaterialDark
    
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
