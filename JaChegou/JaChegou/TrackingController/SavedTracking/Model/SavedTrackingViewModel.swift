//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation
import UIKit


public class SavedTrackingViewModel{
    
    
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
    
}
