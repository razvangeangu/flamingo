//
//  ContentView.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import SwiftUI

struct UserDefaultKeys {
    static let isRegistered = "isRegistered"
}

enum RegistrationPhase {
    case firstRegistration
    case secondRegistration
    case registered
}

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
    
    /// This is the registration step
    @State var registrationPhase: RegistrationPhase = UserDefaults.standard.bool(forKey: UserDefaultKeys.isRegistered) ? .registered : .firstRegistration
    
    var body: some View {
        ZStack(content: {
            // MARK: AR Experience & Card recognition
            ARViewContainer()
                .onCardInfoReceived(perform: { (cardNumber) in
                    self.cardNumber = cardNumber
                })
                .overlay(self.shouldDisplayExperience ? BlurView() : nil)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    hideKeyboard()
                }
            
            // MARK: - Typing pattern registration
            if self.shouldDisplayExperience && self.registrationPhase != .registered {
                VStack {
                    Text(kRegistrationTitle)
                        .font(.system(.headline))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 16, trailing: 12))
                        .multilineTextAlignment(.center)

                    Text(kRegistrationSubtitle)
                        .font(.system(.subheadline))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 16, trailing: 12))
                        .multilineTextAlignment(.center)
                    
                    Text(self.cardNumber.final(characters: 8).creditCardFormat)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(Font.system(.title2))
                        .multilineTextAlignment(.center)

                    TypingDNATextField(text: .constant(""), shouldBecomeFirstResponder: .constant(true))
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
                    
                    Button(self.registrationPhase == .firstRegistration ? kNext : kFinish) {
                        self.saveTypingPattern(text: self.cardNumber.final(characters: 8))

                        if self.registrationPhase == .firstRegistration {
                            self.registrationPhase = .secondRegistration
                        } else {
                            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isRegistered)
                            self.registrationPhase = .registered
                        }
                        
                        TypingDNARecorderMobile.reset()
                    }
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.white)
                    .accentColor(.black)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                    .opacity(0.8)
                }
                .onTapGesture {
                    hideKeyboard()
                }
            }
            
            // MARK: - Identification
            if self.shouldDisplayExperience && self.registrationPhase == .registered {
                VStack {
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width  / 3, height: UIScreen.main.bounds.width  / 3, alignment: .center)
                        .opacity(0.8)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
                        .foregroundColor(Color.white)
                    Text(kInsertCardLabel)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8))
                        .multilineTextAlignment(.center)
                    Text(self.cardNumber.final(characters: 8).creditCardFormat)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(Font.system(.title2))
                        .multilineTextAlignment(.center)
                    TypingDNATextField(text: $textFieldValue, shouldBecomeFirstResponder: .constant(true))
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 60, alignment: .center)
                    Button(kAuthenticateLabel) {
                        self.hideKeyboard()
                        self.verifyTypingPattern()
                    }
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                    .background(Color.white)
                    .accentColor(.black)
                    .cornerRadius(30)
                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    .opacity(0.8)
                    if self.hasAuthError {
                        Text(self.errorMessage)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8))
                            .multilineTextAlignment(.center)
                    }
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
    func saveTypingPattern(text: String) {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else {
            print("Cannot retrieve \"identifierForVendor\"")
            fatalError()
        }
        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, text, 0)
        TypingDNAAPI.shared.save(typingPattern: typingPattern, id: id)
    }
    
    /// Identify pattern using **TypingDNA** API.
    func verifyTypingPattern() {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else {
            print("Cannot retrieve \"identifierForVendor\"")
            fatalError()
        }
        let typingPattern = TypingDNARecorderMobile.getTypingPattern(1, 0, self.cardNumber.final(characters: 8), 0)
        TypingDNAAPI.shared.verify(typingPattern: typingPattern, id: id) { (response) in
            if response.result == 1 {
                self.isAuthenticated = true
            } else {
                self.isAuthenticated = false
                self.errorMessage = response.message == kMessageResponseDefault ? kAuthenticationError : response.message
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
