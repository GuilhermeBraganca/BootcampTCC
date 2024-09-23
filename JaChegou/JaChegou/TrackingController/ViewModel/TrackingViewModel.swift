//
//  TrackingViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

protocol TrackingViewModelProtocol: AnyObject {
    func success()
    func failure(errorMessage: String)
}

class TrackingViewModel {
    
    weak var delegate: TrackingViewModelProtocol?
    private var model: TrackingModel
    
    
    //private var homeView: ListViewModel = ListViewModel()
    private var track: Track
    private var trackingResponse: [TrackingInfoResponse] = []
    
    var onTrackingCodeChanged: ((String) -> Void)?
    var onOrderDescriptionChanged: ((String) -> Void)?
    
    init(model: TrackingModel, track: Track) {
        self.model = model
        self.track = track
    }
    
    func updateTrackingCode(_ code: String) {
        model.trackingCode = code
    }
    
    func updateOrderDescription(_ description: String) {
        model.orderDescription = description
    }
    func fetchTrackingList(completion: @escaping () -> Void) {
        TrackingService.fetchTrackingList() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                trackingResponse = success
                delegate?.success()
                completion()
            case .failure(let failure):
                delegate?.failure(errorMessage: failure.errorDescription ?? "")
                return
            }
        }
    }
    
    func saveTrackingData() {
        
        fetchTrackingList{[weak self] in
            guard let self else { return }
            let track = Track(image: "imageName", description: "description", trackingNumber: "123", date: "22/09/2024", events: [Events(event: "Evento", date: "22/09/2024")])
        }
        
        
        
        //homeView.appendTrackingList(track: track)
//        if track.description.contains("Objeto entregue ao destinatário") {
//            finalizedItems.append(track)
//        } else {
//            inTransitItems.append(track)
//        }
        
        
        
        // Implementar a funcionalidade de salvar os dados
       // print("Código de rastreio: \(trackingResponse[0].cidade)")
        //print("Descrição: \(model.orderDescription)")
        
    }
}
