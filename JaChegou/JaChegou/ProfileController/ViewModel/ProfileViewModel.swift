//
//  ProfileViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 09/11/24.
//

import Foundation

protocol ProfileViewModelDelegate: AnyObject {
    func successfetchUserData(user: User)
    func failureFetchingUserData(errorMessage: String)
    func successDeleteUserAccount()
    func failureDeletingUserAccount(errorMessage: String)
}

class ProfileViewModel {
    
    weak var delegate: ProfileViewModelDelegate?
    func fetchUserData() {
        FirestoreManager.shared.getUserData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    self?.delegate?.successfetchUserData(user: user)
                case .failure(let error):
                    self?.delegate?.failureFetchingUserData(errorMessage: "Erro ao recuperar os dados: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteUserAccount() {
        FirestoreManager.shared.deleteUserAccount { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.delegate?.successDeleteUserAccount()
                case .failure(let error):
                    self?.delegate?.failureDeletingUserAccount(errorMessage: "Erro ao excluir a conta: \(error.localizedDescription)")
                }
            }
        }
    }
    
}
