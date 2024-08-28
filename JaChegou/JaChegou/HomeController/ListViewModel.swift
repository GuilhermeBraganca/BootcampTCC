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

class ListViewModel {
    
    private(set) var trackingType: TrackingType = .transporting
    
    private var trackingList = [Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666"),
                                Track(image: "TrackImage", description: "Teste", date: "66/66/6666")]
    
    private var completeTrackList = [Track(image: "TrackImage", description: "Teste12331", date: "66/66/6666"),
                                     Track(image: "TrackImage", description: "Teste", date: "66/66/6666")]
    
    
    var numberOfRowsInSection: Int {
        
        return trackingType == .transporting ? trackingList.count : completeTrackList.count
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> Track {
        return trackingType == .transporting ? trackingList[indexPath.row] : completeTrackList[indexPath.row]
    }
    
    func setNewTrackingType(newType: TrackingType) {
        trackingType = newType
    }
    
}
