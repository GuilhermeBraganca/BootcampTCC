//
//  FirebaseFirestoreManager.swift
//  AirbnbCloneBootcampProfessor
//
//  Created by Caio Fabrini on 02/10/24.
//

import FirebaseFirestore
import FirebaseAuth


class FirestoreManager {
    
    static let shared = FirestoreManager()
    private let firestore = Firestore.firestore()
    
    private var currentUserID: String? {
        Auth.auth().currentUser?.uid
    }
    
    private init() { }
    
    func createUserWithEmailAndPassword(user : User, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: user.email, password: user.password) {
            result,
            error in
            if let error {
                completion(.failure(error))
            }
            
            guard let userID = result?.user.uid else {
                let error = NSError(domain: "Error ao acessar uid", code: 500)
                completion(.failure(error))
                return
            }
            
            let userDocument = self.firestore.collection("main").document("user").collection(userID).document("userData")
            
            let user = User(id: userID,
                            email: user.email,
                            name:  user.name,
                            password: "",
                            birthDate: user.birthDate ,
                            track: [])
            
            do {
                try userDocument.setData(from: user)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    let user = try document.data(as: User.self)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            case .failure(_):
                print("Deu ruim emm!")
            }
        }
    }
    
    private func getUserDocument(completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
        guard let currentUserID else {
            let error = NSError(domain: "Error ao acessar uid", code: 500)
            completion(.failure(error))
            return
        }
        
        let userDocument = self.firestore.collection("main").document("user").collection(currentUserID).document("userData")
        
        userDocument.getDocument { document, error in
            if let error {
                completion(.failure(error))
            } else if let document, document.exists {
                completion(.success(document))
            } else {
                let error = NSError(domain: "Error, userData não encontrado", code: 500)
                completion(.failure(error))
            }
        }
    }
    
    //  func saveJsonDataOnFirebase() {
    //    // Primeira coisa é verificar se já existe os dados no firebase
    //    getTrackFromFirebase { result in
    //      switch result {
    //      case .success(let places):
    //        print(places)
    //        print("Já existe os dados no firebase")
    //      case .failure(_):
    //        self.fetchPropertiesListMock { result in
    //          switch result {
    //          case .success(let properties):
    //            self.saveJsonDataOnFirebase(properties: properties)
    //          case .failure(_):
    //            print("Erro ao buscar os dados")
    //          }
    //        }
    //      }
    //    }
    //  }
    
    //  func saveJsonDataOnFirebase(properties: [PropertyDataModel]) {
    //    let placesData = properties.compactMap({ try? Firestore.Encoder().encode($0) })
    //    firestore.collection("main").document("places").setData(["placesList": placesData]) { error in
    //      if let error {
    //        print("Error saving data: \(error)")
    //      } else {
    //        print("Data saved successfully!")
    //      }
    //    }
    //  }
    //
    //  func getTrackFromFirebase(completion: @escaping (Result<[Track],Error>) -> Void) {
    //
    //      let documentRef = firestore.collection("main").document("places")
    //
    //    documentRef.getDocument { document, error in
    //
    //      if let error {
    //        completion(.failure(error))
    //      }
    //
    //      guard let document, document.exists,
    //            let placesData = document.data()?["placesList"] as? [[String: Any]] else {
    //        let error = NSError(domain: "Error, placesList não encontrado", code: 500)
    //        completion(.failure(error))
    //        return
    //      }
    //
    //      let places = placesData.compactMap({ return try? JSONDecoder().decode(PropertyDataModel.self, from: JSONSerialization.data(withJSONObject: $0))})
    //
    //      if places.isEmpty {
    //        let error = NSError(domain: "Error, placesList está vazio", code: 500)
    //        completion(.failure(error))
    //      } else {
    //        completion(.success(places))
    //      }
    //    }
    //  }
    //
    //  func fetchPropertiesListMock(completion: @escaping (Result<[PropertyDataModel],Error>) -> Void) {
    //    LocalFileReader.loadJSON(fileName: "place", type: [PropertyDataModel].self) { result in
    //      switch result {
    //      case .success(let properties):
    //        completion(.success(properties))
    //      case .failure(let error):
    //        completion(.failure(error))
    //      }
    //    }
    //  }
    //
    //  // Verificar se o meu place especifico é favorito!
    //  func isPropertyFavorite(id: Int, completion: @escaping (Bool) -> Void) {
    //    getUserDocument { result in
    //      switch result {
    //      case .success(let document):
    //        do {
    //          let userData = try document.data(as: User.self)
    //          let isFavorite = userData.favorite.contains(id)
    //          print("É favorito o id \(id): \(isFavorite)")
    //          completion(isFavorite)
    //        } catch {
    //          print("Deu error")
    //          completion(false)
    //        }
    //      case .failure:
    //        print("Deu error")
    //        completion(false)
    //      }
    //    }
    //  }
    //
    //  // Adicionar/Remover favorito do BD
    func addTrackToUser(track: Track, completion: @escaping (Result<Void,Error>) -> Void) {
        
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    if let index = userData.track.firstIndex(of: track) {
                        // Retorna um erro customizado para indicar que o rastreio já foi adicionado
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "O rastreio já foi adicionado anteriormente."])
                        completion(.failure(error))
                        return
                    } else {
                        userData.track.append(track)
                    }
                    try document.reference.setData(from: userData)
                    
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func updateTrackToUser(track: Track, completion: @escaping (Result<Void,Error>) -> Void) {
        
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    
                    // Verifica se o track já existe
                    if let index = userData.track.firstIndex(where: { $0.trackingNumber == track.trackingNumber }) {
                        // Atualiza os eventos do rastreio existente
                        userData.track[index].events = track.events
                        
                        // Atualiza o documento no Firestore
                        try document.reference.setData(from: userData)
                        
                        // Retorna sucesso
                        completion(.success(()))
                    } else {
                        // Se o rastreio não existir, adiciona um novo
                        userData.track.append(track)
                        
                        // Atualiza o documento no Firestore
                        try document.reference.setData(from: userData)
                        
                        // Retorna sucesso
                        completion(.success(()))
                    }
                } catch {
                    // Lida com erro na tentativa de atualizar o Firestore
                    completion(.failure(error))
                }
            case .failure(let error):
                // Lida com erro ao obter o documento do usuário
                completion(.failure(error))
            }
        }
    }
    func getTracksFromUser(completion: @escaping (Result<[Track],Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    // Tente decodificar o documento do usuário
                    let userData = try document.data(as: User.self)
                    // Recuperar a lista de tracks do usuário
                    let userTracks = userData.track
                    // Retorna a lista de tracks com sucesso
                    completion(.success(userTracks))
                } catch {
                    // Se ocorrer um erro ao decodificar os dados, o erro é retornado
                    completion(.failure(error))
                }
            case .failure(let error):
                // Se houver um erro ao recuperar o documento do Firestore
                completion(.failure(error))
            }
        }
    }
    func deleteTrackFromUser(track: Track, completion: @escaping (Result<Void, Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    
                    // Remove o track com o mesmo trackingNumber
                    userData.track.removeAll { $0.trackingNumber == track.trackingNumber }
                    
                    // Salva a lista atualizada no Firestore
                    try document.reference.setData(from: userData)
                    
                    // Chama o completion com sucesso
                    completion(.success(()))
                    
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
