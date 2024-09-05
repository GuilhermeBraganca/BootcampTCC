//
//  SavedTrackingViewModel.swift
//  JaChegou
//
//  Created by MacBook on 04/09/24.
//

import Foundation
import UIKit


public class SavedTrackingViewModel{
    
    
    private var trackingData = [Track(image: "truck.box.fill", description: "Teste", date: "66/66/6666", events: [Events(event: "Objeto em trânsito para Unidade de Distribuição em Brasília / DF", date:"02/05/2022")])];
    
    
    var numberOfRowsInSection: Int {
        
        return trackingData.count
    }
    
    func loadCurrentDetail(indexPath: IndexPath) -> Track {
        return  trackingData[indexPath.row] 
    }
}
