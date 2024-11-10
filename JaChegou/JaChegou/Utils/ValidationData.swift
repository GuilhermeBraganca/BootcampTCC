//
//  ValidationData.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 02/11/24.
//

import Foundation

class ValidationData {
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    static func isValidConfirmPassword(_ password: String, _ confirmPassword: String) -> Bool {
        return password == confirmPassword
    }
}
