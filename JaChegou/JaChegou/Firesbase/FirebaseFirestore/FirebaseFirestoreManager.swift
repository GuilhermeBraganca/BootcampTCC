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
    
    func deleteUserAccount(completion: @escaping (Result<Void, Error>) -> Void) {
        // Obter o usuário autenticado atual
        guard let user = Auth.auth().currentUser else {
            completion(.failure(NSError(domain: "No user is currently logged in", code: 0, userInfo: nil)))
            return
        }
        
        // Tenta excluir o usuário
        user.delete { error in
            if let error = error {
                // Se houver erro, verificar se é necessário reautenticar
                if let authError = error as NSError?, authError.code == AuthErrorCode.requiresRecentLogin.rawValue {
                    // Aqui, você pode solicitar a reautenticação do usuário antes de excluir
                    completion(.failure(NSError(domain: "Reauthentication required", code: 0, userInfo: nil)))
                } else {
                    // Retorna qualquer outro erro
                    completion(.failure(error))
                }
            } else {
                // Se tudo ocorreu bem, a conta foi excluída
                completion(.success(()))
            }
        }
    }
    func addTrackToUser(track: Track, completion: @escaping (Result<Void,Error>) -> Void) {
        
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    if let index = userData.track.firstIndex(of: track) {
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
    
    func updateTrackToUser(track: Track, completion: @escaping (Result<Void, Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    if let index = userData.track.firstIndex(where: { $0.trackingNumber == track.trackingNumber }) {
                        let newUniqueEvents = self.getNewEvents(currentEvents: userData.track[index].events, newEvents: track.events)
                        userData.track[index].events = track.events
                        self.saveUserData(userData: userData, document: document, completion: completion)
                    } else {
                        userData.track.append(track)
                        //userData.newEvents.append(contentsOf: track.events)
                        self.saveUserData(userData: userData, document: document, completion: completion)
                    }
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getTracksFromUser(completion: @escaping (Result<[Track],Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    let userData = try document.data(as: User.self)
                    let userTracks = userData.track
                    completion(.success(userTracks))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getNewEvents(currentEvents: [Events], newEvents: [Events]) -> [Events] {
        return newEvents.filter { newEvent in
            !currentEvents.contains { existingEvent in
                return existingEvent.descricao == newEvent.descricao && existingEvent.cidade == newEvent.cidade
            }
        }
    }
    
    func saveUserData(userData: User, document: DocumentSnapshot, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try document.reference.setData(from: userData)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteTrackFromUser(track: Track, completion: @escaping (Result<Void, Error>) -> Void) {
        getUserDocument { result in
            switch result {
            case .success(let document):
                do {
                    var userData = try document.data(as: User.self)
                    userData.track.removeAll { $0.trackingNumber == track.trackingNumber }
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
}
