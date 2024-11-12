//
//  ProfileViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 09/11/24.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func didFetchUserData(_ user: User)
    func didFailFetchingUserData(with error: Error)
    func didDeleteUserAccount()
    func didFailDeletingUserAccount(with error: Error)
}

class ProfileViewModel {
    weak var delegate: ProfileViewModelDelegate?
    
    func fetchUserData() {
        FirestoreManager.shared.getUserData { [weak self] result in
            switch result {
            case .success(let user):
                self?.delegate?.didFetchUserData(user)
            case .failure(let error):
                self?.delegate?.didFailFetchingUserData(with: error)
            }
        }
    }
    
    func deleteUserAccount() {
        FirestoreManager.shared.deleteUserAccount { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.didDeleteUserAccount()
            case .failure(let error):
                self?.delegate?.didFailDeletingUserAccount(with: error)
            }
        }
    }
}
