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
    
    private var trackingList = [Track(image: "TrackImage", description: "Teste12331", trackingNumber: "AB 123456789 BR",date: "66/66/6666")]
    
    //                                Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666"),
    //                                Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666"),
    //                                Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666"),
    //                                Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666"),
    //                                Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666")]
    
    private var completeTrackList = [Track]()
    
    //    [Track(image: "TrackImage", description: "Teste12331", trackinNumber: "AB 123456789 BR",date: "66/66/6666"),
    //                                     Track(image: "TrackImage", description: "Teste", trackinNumber: "AB 123456789 BR",date: "66/66/6666")]
    var onDataChanged: (() -> Void)?
    
    func notifyDataChanged() {
        onDataChanged?()
    }
    
    func appendTrackingList(track: Track){
        trackingList.append(track)
    }
    var numberOfRowsInSection: Int {
        
        return trackingType == .transporting ? (trackingList.isEmpty ? 1 : trackingList.count) : (completeTrackList.isEmpty ? 1 : completeTrackList.count )
    }
    
    var totalOfTrackingList: Int {
        return trackingType == .transporting ? trackingList.count :completeTrackList.count
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> Track {
        return trackingType == .transporting ? trackingList[indexPath.row] : completeTrackList[indexPath.row]
    }
    
    func setNewTrackingType(newType: TrackingType) {
        trackingType = newType
    }
    
}
extension ListViewModel: TrackingViewModelProtocol{
    func success() {
        //<#code#>
    }
    
    func failure(errorMessage: String) {
        //<#code#>
    }
    
    // Implementação do método delegate
    func didSaveTrackingData(track: Track) {
        appendTrackingList(track: track)
        notifyDataChanged()
    }
}
