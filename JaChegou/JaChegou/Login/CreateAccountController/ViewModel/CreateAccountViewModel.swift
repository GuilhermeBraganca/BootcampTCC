//
//  CreateAccountViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/10/24.
//

import Foundation

class CreateAccountViewModel {
    func createUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.createUserWithEmailAndPassword(user: user) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
