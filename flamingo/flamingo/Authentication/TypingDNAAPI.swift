//
//  TypingDNAAPI.swift
//  flamingo
//
//  Created by Răzvan-Gabriel Geangu on 20/10/2020.
//

import Foundation

class TypingDNAAPI: NSObject {
    /// This function takes typingPattern string generated by the recorder as an argument
    /// It uses the API from **TypingDNA** to register a person
    /// @see *Save typing pattern* from documentation
    func register(typingPattern: String) {
    }
    
    /// This function takes typingPattern string generated by the recorder as an argument
    /// It uses the API from **TypingDNA** to identify a person
    /// @see *Verify typing pattern* from documentation
    func identify() -> Bool {
        return false
    }
}
