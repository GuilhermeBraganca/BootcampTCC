//
//  ProfileViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 09/11/24.
//

import Foundation

protocol ProfileViewModelProtocol {
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void)
    func deleteUserAccount(completion: @escaping (Result<Void, Error>) -> Void)
}

class ProfileViewModel: ProfileViewModelProtocol {
    func fetchUserData(completion: @escaping (Result<User, Error>) -> Void) {
        FirestoreManager.shared.getUserData(completion: completion)
    }
    
    func deleteUserAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.deleteUserAccount(completion: completion)
    }
}
