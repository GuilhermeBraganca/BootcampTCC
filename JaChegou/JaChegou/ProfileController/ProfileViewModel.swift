//
//  ProfileViewModel.swift
//  JaChegou
//
//  Created by Giulia Marinho on 22/09/24.
//
import UIKit
import Foundation

class ProfileViewModel {
    var userModel: ProfileModel
    var isEditing: Bool = false
    
    init(email: String, password: String) {
        self.userModel = ProfileModel(email: email, password: password)
    }
    
    func validateFields(email: String, password: String) -> Bool {
        userModel.email = email
        userModel.password = password
        return userModel.isValidEmail() && userModel.isValidPassword()
    }
}

