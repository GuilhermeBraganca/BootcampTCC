//
//  TrackingViewModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation
import UIKit

protocol TrackingViewModelProtocol: AnyObject {
    func success()
    func failure(errorMessage: String)
    func loading(start: Bool)
}

class TrackingViewModel {
    
    weak var delegate: TrackingViewModelProtocol?
    
    func saveTrackingData(code: String, description: String) {
        delegate?.loading(start: true)
        TrackingService.fetchTrackingList(code: code) { [weak self] result in
            guard let self else { return }
            delegate?.loading(start: false)
            switch result {
            case .success(let success):
                handlerTrackingResponse(code: code, description: description, list: success)
            case .failure(let failure):
                delegate?.failure(errorMessage: failure.errorDescription ?? "")
                return
            }
            
        }
    }
    func saveMockTrackingData(code: String, description: String) {
        delegate?.loading(start: true)
        LocalFileReader.loadJSON(fileName: "TrackIncomplete", type: [Events].self) { [weak self] result in
            guard let self else { return }
            delegate?.loading(start: false)
            switch result {
            case .success(let success):
                handlerTrackingResponse(code: code, description: description, list: success)
            case .failure(let failure):
                delegate?.failure(errorMessage: failure.errorDescription ?? "")
                return
            }
            
        }
    }
    func handlerTrackingResponse(code: String, description: String, list: [Events]) {
        let track = Track(image: "", description: description, trackingNumber: code, date: "", events: list)
        configDecodableListTrackingDTO(track: track)
    }
    
    
    func configDecodableListTrackingDTO(track: Track) {
        FirestoreManager.shared.addTrackToUser(track: track) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success:
                print("Track adicionado com sucesso!")
                self.delegate?.success()  // Chama o delegate em caso de sucesso
            case .failure(let error):
                // Envia a mensagem de erro para o ViewController
                self.delegate?.failure(errorMessage: error.localizedDescription)
            }
        }
    }
}

extension NSNotification.Name {
    static let trackingDTO = Self("TrackingDTO")
}
