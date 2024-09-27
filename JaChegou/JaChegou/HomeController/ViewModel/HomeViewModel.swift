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

class HomeViewModel {
    
    private(set) var trackingType: TrackingType = .transporting
    
    var allTrackList: [TrackingDTO] = []
    
    var trackingList: [TrackingDTO] {
        return allTrackList.filter { objc in
            return objc.trackingList.allSatisfy { ($0.descricao?.uppercased() ?? "") != "Objeto entregue ao destinatário".uppercased() }
        }
    }

    var completeTrackList: [TrackingDTO] {
        return allTrackList.filter { objc in
            return objc.trackingList.contains { ($0.descricao?.uppercased() ?? "") == "Objeto entregue ao destinatário".uppercased() }
        }
    }
    
    var numberOfRowsInSection: Int {
        
        return trackingType == .transporting ? (trackingList.isEmpty ? 1 : trackingList.count) : (completeTrackList.isEmpty ? 1 : completeTrackList.count )
    }
    
    var totalOfTrackingList: Int {
        return trackingType == .transporting ? trackingList.count : completeTrackList.count
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> TrackingDTO {
        return trackingType == .transporting ? trackingList[indexPath.row] : completeTrackList[indexPath.row]
    }
    
    func setNewTrackingType(newType: TrackingType) {
        trackingType = newType
    }
}
