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
    @State var cardNumber: String!
    @State var authenticated: Bool = false
    @State var hasAuthError: Bool = false
    
    var body: some View {
        ZStack(content: {
            ARViewContainer(totalBalance: $totalBalance)
                .onCardInfoReceived(perform: { (cardNumber) in
                    let index = cardNumber.index(cardNumber.endIndex, offsetBy: -8)
                    self.cardNumber = String(cardNumber[index...])
                })
                .overlay(self.cardNumber != nil && !self.authenticated ? Blur() : nil)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }
            if self.cardNumber != nil && !self.authenticated {
                VStack {
                    Text("Insert your card number to authenticate")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                        .multilineTextAlignment(.center)
                    Text(cardNumber.formatCreditCard())
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(Font.system(.title2))
                        .multilineTextAlignment(.center)
                    TypingDNATextField()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
                    Button("Authenticate") {
                        hideKeyboard()
                        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, self.cardNumber, 0)
                        // razzzy6g
                        // ionut52
//                        TypingDNAAPI.shared.register(typingPattern: typingPattern, id: "razzzy6g")
                        TypingDNAAPI.shared.identify(typingPattern: typingPattern, id: "razzzy6g") { (response) in
                            if response.result == 1 {
                                self.authenticated = true
                            } else {
                                self.authenticated = false
                                self.hasAuthError = true
                            }
                        }
                    }
                    .alert(isPresented: $hasAuthError) {
                        Alert(title: Text("Authentication error"), message: Text("Please try again"), dismissButton: .default(Text("OK"), action: {
                            self.hasAuthError = false
                        }))
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
