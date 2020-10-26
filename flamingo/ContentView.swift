//
//  ContentView.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI

struct ContentView: View {
    /// Card number will be recognised and set through the CardIO API.
    /// This will be shown on screen and will be used for identification.
    @State var cardNumber: String!
    
    /// This enables the AR experience once the user has been successfuly identified by the **TypingDNA** API.
    @State var isAuthenticated: Bool = false
    
    /// This displays the authentication error if **TypingDNA** API is not successfull.
    @State var hasAuthError: Bool = false
    
    /// This displays the error message from the **TypingDNA** API or the `kAuthenticationError`.
    @State var errorMessage: String = kAuthenticationError
    
    /// This is the value of the authentication text field
    @State var textFieldValue: String?
    
    var body: some View {
        ZStack(content: {
            // MARK: AR Experience & Card recognition
            ARViewContainer()
                .onCardInfoReceived(perform: { (cardNumber) in
                    self.cardNumber = cardNumber.final(characters: 8)
                })
                .overlay(self.shouldDisplayExperience ? BlurView() : nil)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }

            // MARK: - Identification
            if self.shouldDisplayExperience {
                VStack {
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width  / 3, height: UIScreen.main.bounds.width  / 3, alignment: .center)
                        .opacity(0.8)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                    Text(kInsertCardLabel)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8))
                        .multilineTextAlignment(.center)
                    Text(self.cardNumber.creditCardFormat)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(Font.system(.title2))
                        .multilineTextAlignment(.center)
                    TypingDNATextField(text: $textFieldValue)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
                    Button(kAuthenticateLabel) {
                        self.hideKeyboard()
                        self.verifyTypingPattern()
                    }
                    .alert(isPresented: $hasAuthError) {
                        Alert(title: Text(self.errorMessage), message: Text(kTryAgainLabel), dismissButton: .default(Text(kOk), action: {
                            self.errorMessage = kAuthenticationError
                            self.hasAuthError = false
                        }))
                    }
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.white)
                    .accentColor(.black)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                    .opacity(0.8)
                }
            }
        })
    }
    
    /// If the card number is defined and the user has been successfully authenticated the function will return `true`.
    var shouldDisplayExperience: Bool {
        get {
            return self.cardNumber != nil && !self.isAuthenticated
        }
    }
    
    // MARK: - TypingDNA implementation
    
    /// Save typing pattern using **TypingDNA** API.
    func saveTypingPattern() {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else {
            print("Cannot retrieve \"identifierForVendor\"")
            fatalError()
        }
        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, self.cardNumber, 0)
        TypingDNAAPI.shared.save(typingPattern: typingPattern, id: id)
    }
    
    /// Identify pattern using **TypingDNA** API.
    func verifyTypingPattern() {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else {
            print("Cannot retrieve \"identifierForVendor\"")
            fatalError()
        }
        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, self.cardNumber, 0)
        TypingDNAAPI.shared.verify(typingPattern: typingPattern, id: id) { (response) in
            if response.result == 1 {
                self.isAuthenticated = true
            } else {
                self.isAuthenticated = false
                self.errorMessage = response.message
                self.hasAuthError = true
                self.textFieldValue = ""
                TypingDNARecorderMobile.reset()
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
