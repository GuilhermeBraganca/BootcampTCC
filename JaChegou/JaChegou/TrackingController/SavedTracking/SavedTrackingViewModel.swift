//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation
import UIKit


public class SavedTrackingViewModel{
    
    
    private var trackingData = TrackingDTO(code: "", description: "", trackingList: [])
                                                                                                                                    
    var numberOfRowsInSection: Int {
        return trackingData.trackingList.count
    }
    func removeAll() {
        //trackingData = Track(image: "", description: "", trackingNumber: "", date: "", events: [])
    }
    func loadTrackingData(tracking: TrackingDTO) {
        trackingData = tracking
    }
    func loadCurrentTrack() -> TrackingDTO {
        return trackingData
    }
    func loadCurrentDetail(indexPath: IndexPath) -> TrackingInfoResponse {
        return  trackingData.trackingList[indexPath.row]
    }
    
}
