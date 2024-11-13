//
//  NotificationViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

protocol NotificationViewModelDelegate: AnyObject {
    func showAlert(title: String, message: String)
}

class NotificationViewModel {

    weak var delegate: NotificationViewModelDelegate?
    private var trackWithLastEvents: [Notification] = []
    
    var numberOfRowsInSection: Int {
        return trackWithLastEvents.count
    }
    
    func trackWithLastEvent(at indexPath: IndexPath) -> Notification {
        return trackWithLastEvents[indexPath.row]
    }
    
    func getAllEvents(){
        FirestoreManager.shared.getUserData{ [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let userData):
                let trackWithLastEvents = userData.track.compactMap { track -> Notification? in
                    guard let lastEvent = track.events.first else { return nil }
                    return Notification(track: track, lastEvent: lastEvent)
                }
                self.trackWithLastEvents = trackWithLastEvents
            case .failure(let error):
                self.delegate?.showAlert(title: "Erro", message: "Erro ao carregar os dados de rastreamento: \(error.localizedDescription)")
            }
        }
    }
}
