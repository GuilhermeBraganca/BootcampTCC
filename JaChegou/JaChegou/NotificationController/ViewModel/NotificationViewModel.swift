//
//  NotificationViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

class NotificationViewModel {
#warning("porque deixar dentro essa struct?")
    struct TrackWithLastEvent {
        let track: Track
        let lastEvent: Events
    }
#warning("deixar privada")
    var trackWithLastEvents: [TrackWithLastEvent] = []
    
    var numberOfRowsInSection: Int {
        return trackWithLastEvents.count
    }
    
    func trackWithLastEvent(at indexPath: IndexPath) -> TrackWithLastEvent {
        return trackWithLastEvents[indexPath.row]
    }
}
