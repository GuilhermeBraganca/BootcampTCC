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
    func loading(start: Bool)
}

class TrackingViewModel {

  weak var delegate: TrackingViewModelProtocol?

  func saveTrackingData(code: String, description: String) {
    delegate?.loading(start: true)
    TrackingService.fetchTrackingList(code: "NM455753071BR") { [weak self] result in
      guard let self else { return }
      delegate?.loading(start: false)
      switch result {
      case .success(let success):
        handlerTrackingResponse(code: "NM455753071BR", description: description, list: success)
      case .failure(let failure):
        delegate?.failure(errorMessage: failure.errorDescription ?? "")
        return
      }
        
    }
  }

  func handlerTrackingResponse(code: String, description: String, list: [TrackingInfoResponse]) {
    let track = TrackingDTO(code: code, description: description, trackingList: list)
    configDecodableListTrackingDTO(track: track)
  }

  func configDecodableListTrackingDTO(track: TrackingDTO) {
    var list: [TrackingDTO] = []
    if let data = UserDefaults.standard.object(forKey: "ListTrackingDTO") as? Data {
      if let listTrack: [TrackingDTO] = try? JSONDecoder().decode([TrackingDTO].self, from: data) {
        list = listTrack
      } else {
        print("error decode!")
        return
      }
    }

    list.append(track)
    configEncodableTrackingDTO(track: list)
  }

  func configEncodableTrackingDTO(track: [TrackingDTO]) {
    let defaults = UserDefaults.standard
    if let data = try? JSONEncoder().encode(track) {
      defaults.set(data, forKey: "ListTrackingDTO")
      delegate?.success()
    } else {
      delegate?.failure(errorMessage: "Error Encode")
    }
  }
}

extension NSNotification.Name {
  static let trackingDTO = Self("TrackingDTO")
}
