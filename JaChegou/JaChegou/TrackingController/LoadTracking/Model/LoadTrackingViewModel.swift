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
    }
    func handleTrackingUpdates(track: Track, newEvents: [Events]) {
        // Obter apenas os novos eventos
        let newUniqueEvents = getNewEvents(currentEvents: track.events, newEvents: newEvents)
        
        if !newUniqueEvents.isEmpty {

            var updatedTrack = track
            updatedTrack.events = newUniqueEvents // Sobrescreve os eventos com apenas os novos
            
            // Atualiza o rastreamento no Firestore com todos os eventos
            FirestoreManager.shared.updateTrackToUser(track: trackingData) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success:
                    // Atualiza o trackingData no ViewModel
                    trackingData.events.append(contentsOf: newUniqueEvents) // Adiciona os novos eventos ao conjunto completo
                    
                    // Postar o updatedTrack no NotificationCenter (apenas os novos eventos)
                    NotificationCenter.default.post(name: .updateTrack, object: updatedTrack)
                    
                    // Notifica o sucesso com mensagem de atualização
                    self.delegate?.success(message: "Novos eventos adicionados com sucesso!")
                    
                case .failure(let error):
                    self.delegate?.failure(errorMessage: error.localizedDescription)
                }
            }
        } else {
            // Não há novos eventos
            self.delegate?.success(message: "Nenhuma atualização no rastreamento.") // Notifica que não houve mudanças
        }
    }
    
    func getNewEvents(currentEvents: [Events], newEvents: [Events]) -> [Events] {
        // Filtra apenas os eventos que não estão presentes na lista atual de eventos
        let newUniqueEvents = newEvents.filter { newEvent in
            return !currentEvents.contains(where: {
                $0.descricao == newEvent.descricao && $0.cidade == newEvent.cidade
            })
        }
        return newUniqueEvents
    }
}

extension NSNotification.Name {
    static let updateTrack = Self("changeName")
}
