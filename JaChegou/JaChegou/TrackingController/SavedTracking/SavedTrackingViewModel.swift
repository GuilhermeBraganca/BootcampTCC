//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation
import UIKit


public class SavedTrackingViewModel{
    
    
    private var trackingData = Track(image: "truck.box.fill", description: "Teste", trackinNumber: "BC 123456789 BR", date: "66/66/6666", events: [Events(event: "Objeto em trânsito para Unidade de Distribuição em Brasília / DF", date:"02/05/2022"),
         Events(event: "Objeto em trânsito para Unidade de Distribuição em SAO PAULO / SP", date:"02/08/2022"),
         Events(event: "Objeto em trânsito para Unidade de Distribuição em MINAS / SP", date:"02/09/2022")
                                                                                                                                                   
        ]);
    
    
    var numberOfRowsInSection: Int {
        
        return trackingData.events.count
    }
    func removeAll() {
        trackingData = Track(image: "", description: "", trackinNumber: "", date: "", events: [])
    }

    func loadCurrentTrack() -> Track {
        return trackingData
    }
    func loadCurrentDetail(indexPath: IndexPath) -> Events {
        return  trackingData.events[indexPath.row]
    }
    
}
