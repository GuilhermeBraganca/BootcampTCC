//
//  CreateAccountViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 15/10/24.
//

import Foundation

class CreateAccountViewModel {
#warning("não faz sentido ter isso aqui...")
//    var user: User = User(id: "", email: "", name: "", password: "", birthDate: "", track: [])

  func createUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        FirestoreManager.shared.createUserWithEmailAndPassword(user: user) { result in
            switch result {
            case .success:
                #warning("remover print totalmente desnecessario, pois já foi validado esse caso")
                print("criado com sucesso")
                completion(.success(()))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
}







