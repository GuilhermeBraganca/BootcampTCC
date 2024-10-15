//
//  CreateAccountViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/10/24.
//

import Foundation

class CreateAccountViewModel {
    var user: User = User(id: "", email: "", name: "", password: "", birthDate: "", track: [])

    func createUser(completion: @escaping (Result<Void, Error>) -> Void) {
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








