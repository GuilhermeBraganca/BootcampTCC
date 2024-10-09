//
//  ListViewModel.swift
//  JaChegou
//
//  Created by MacBook on 19/08/24.
//

import UIKit

enum TrackingType {
    case completed
    case transporting
}
protocol HomeViewModelDelegate: AnyObject {
    func didLoadTracks(tracks: [Track])
}

class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
    private(set) var trackingType: TrackingType = .transporting
    
    var allTrackList: [Track] = []
    var trackFilter: [Track] = []
    
    func updateTrackFilter() {
        // Atualiza o filtro com todos os itens após os dados serem carregados
        self.trackFilter = allTrackList
    }
    
    func setNewTrackingType(newType: TrackingType) {
        trackingType = newType
    }
    func removeTrack(_ track: Track) {
            allTrackList.removeAll { $0.trackingNumber == track.trackingNumber }
            trackFilter.removeAll { $0.trackingNumber == track.trackingNumber }
        }

    func filterTrack(text: String){
        if text.isEmpty {
            trackFilter = allTrackList
        } else {
            trackFilter = allTrackList.filter { $0.description.lowercased().contains(text.lowercased()) }
        }
    }
    var trackingList: [Track] {
        return trackFilter.filter { objc in
            return objc.events.allSatisfy { ($0.descricao?.uppercased() ?? "") != "Objeto entregue ao destinatário".uppercased() }
        }
    }
    
    var completeTrackList: [Track] {
        return trackFilter.filter { objc in
            return objc.events.contains { ($0.descricao?.uppercased() ?? "") == "Objeto entregue ao destinatário".uppercased() }
        }
    }
    
    var numberOfRowsInSection: Int {
        return trackingType == .transporting ? (trackingList.isEmpty ? 1 : trackingList.count) : (completeTrackList.isEmpty ? 1 : completeTrackList.count)
    }
    
    var totalOfTrackingList: Int {
        return trackingType == .transporting ? trackingList.count : completeTrackList.count
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> Track {
        return trackingType == .transporting ? trackingList[indexPath.row] : completeTrackList[indexPath.row]
    }
    
}
