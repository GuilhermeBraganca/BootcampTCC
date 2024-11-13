//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation


protocol LoadTrackingViewModelDelegate: AnyObject {
    func success(message: String)
    func failure(errorMessage: String)
    func loading(start: Bool)
    func showAlertDeleteTrackingSuccess(title: String, message: String)
    func showAlertDeleteTrackingFailure(title: String, message: String)
}

public class LoadTrackingViewModel {
    
    weak var delegate: LoadTrackingViewModelDelegate?
    private var trackingData = Track(image: "", description: "", trackingNumber: "", date: "", events: [])
    
    var numberOfRowsInSection: Int {
        return trackingData.events.count
    }
    
    func loadTrackingData(tracking: Track) {
        trackingData = tracking
    }
    
    func loadCurrentTrack() -> Track {
        return trackingData
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> Events {
        return  trackingData.events[indexPath.row]
    }
    
    func checkForUpdates(track: Track) {
        delegate?.loading(start: true)
        APITrackingClient.fetchTrackingList(code: track.trackingNumber) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.loading(start: false)
            
            switch result {
            case .success(let newEvents):
                self.handleTrackingUpdates(track: track, newEvents: newEvents)
            case .failure(let failure):
                self.delegate?.failure(errorMessage: failure.errorDescription ?? "")
            }
        }
    }
    
    func handleTrackingUpdates(track: Track, newEvents: [Events]) {
        if track.events != newEvents {
            var updatedTrack = track
            updatedTrack.events = newEvents
            FirestoreManager.shared.updateTrackToUser(track: updatedTrack) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    trackingData = updatedTrack
                    self.delegate?.success(message: "Novos eventos adicionados com sucesso!")
                case .failure(let error):
                    self.delegate?.failure(errorMessage: error.localizedDescription)
                }
            }
        } else {
            self.delegate?.success(message: "Nenhuma atualização no rastreamento.")
        }
    }
    
    func getNewEvents(currentEvents: [Events], newEvents: [Events]) -> [Events] {
        let newUniqueEvents = newEvents.filter { newEvent in
            return !currentEvents.contains(where: {
                $0.descricao == newEvent.descricao && $0.cidade == newEvent.cidade
            })
        }
        return newUniqueEvents
    }
    
    func deleteTrackingConfirmed(track: Track) {
        FirestoreManager.shared.deleteTrackFromUser(track: track) { [weak self] result in
            guard let self else {return}
            switch result {
            case .success:
                self.delegate?.showAlertDeleteTrackingSuccess(title: "Sucesso", message: "O rastreio foi deletado.")
            case .failure(let error):
                self.delegate?.showAlertDeleteTrackingFailure(title: "Erro", message: "Falha ao deletar o rastreio: \(error.localizedDescription)")
            }
        }
    }
}
