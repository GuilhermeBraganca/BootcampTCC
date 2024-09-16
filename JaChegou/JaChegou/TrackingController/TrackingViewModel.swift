//
//  TrackingViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

class TrackingViewModel {
    
    private var model: TrackingModel {
        didSet {
            // Notificar as mudanças
            onTrackingCodeChanged?(model.trackingCode)
            onOrderDescriptionChanged?(model.orderDescription)
        }
    }
    
    var onTrackingCodeChanged: ((String) -> Void)?
    var onOrderDescriptionChanged: ((String) -> Void)?
    
    init(model: TrackingModel) {
        self.model = model
    }
    
    func updateTrackingCode(_ code: String) {
        model.trackingCode = code
    }
    
    func updateOrderDescription(_ description: String) {
        model.orderDescription = description
    }
    
    func saveTrackingData() {
        // Implementar a funcionalidade de salvar os dados
        print("Código de rastreio: \(model.trackingCode)")
        print("Descrição: \(model.orderDescription)")
    }
}
