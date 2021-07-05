//
//  LoginViewModel.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 3/07/21.
//

import Foundation

class LoginViewModel {
    
    func isValidName(textName: String) -> Bool {
        guard textName.count > 3, textName.count < 18 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: textName)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
