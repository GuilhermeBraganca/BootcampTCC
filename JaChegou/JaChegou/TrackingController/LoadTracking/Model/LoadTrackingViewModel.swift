//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation
import UIKit

protocol LoadTrackingViewModelProtocol: AnyObject {
    func success(message: String)
    func failure(errorMessage: String)
    func loading(start: Bool)
}

public class LoadTrackingViewModel{
    
    weak var delegate: LoadTrackingViewModelProtocol?
    
    private var trackingData = Track(image: "", description: "", trackingNumber: "", date: "", events: [])
    
    var numberOfRowsInSection: Int {
        return trackingData.events.count
    }
    func removeAll() {
        //trackingData = Track(image: "", description: "", trackingNumber: "", date: "", events: [])
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
        
        // Verifica se o número de rastreamento é o mock
        if track.trackingNumber == "NM455753072BR" {
            // Carrega o mock se o número de rastreamento for igual ao mock desejado
            LocalFileReader.loadJSON(fileName: "TrackIncomplete", type: [Events].self) { [weak self] result in
                guard let self = self else { return }
                self.delegate?.loading(start: false)
                
                switch result {
                case .success(let mockEvents):
                    self.handleTrackingUpdates(track: track, newEvents: mockEvents)
                case .failure(let error):
                    self.delegate?.failure(errorMessage: error.localizedDescription)
                }
            }
        } else {
            // Caso contrário, chama o serviço real
            TrackingService.fetchTrackingList(code: track.trackingNumber) { [weak self] result in
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
    }
    func handleTrackingUpdates(track: Track, newEvents: [Events]) {
        if track.events != newEvents {
            var updatedTrack = track
            updatedTrack.events = newEvents
            FirestoreManager.shared.updateTrackToUser(track: updatedTrack) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    
                    trackingData = updatedTrack
                    self.delegate?.success(message: "Track atualizado com sucesso!")  // Notifica o sucesso
                    
                case .failure(let error):
                    self.delegate?.failure(errorMessage: error.localizedDescription)
                }
            }
        } else {
            self.delegate?.success(message: "Nenhuma atualização no rastreamento.") // Notifica que está atualizado, sem mudanças
        }
    }
}
