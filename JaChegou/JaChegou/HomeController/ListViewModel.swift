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

  private var trackingList: [Track] = [Track(list: [Item(image: "TrackingImage", description: "Teste3", date: "66/66/6666"), Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666")])]

  private var completeTrackList: [Track] = [Track(list: [Item(image: "TrackingImage", description: "Teste3", date: "66/66/6666"), Item(image: "TrackingImage", description: "Teste", date: "66/66/6666")])]


  var numberOfRowsInSection: Int {
//    if trackingType == .transporting {
//      return trackingList.count
//    }
//    return completeTrackList.count

    return trackingType == .transporting ? trackingList.count : completeTrackList.count
  }

  func loadCurrentDetail(indexPath: IndexPath) -> Track {
    return trackingType == .transporting ? trackingList[indexPath.row] : completeTrackList[indexPath.row]
  }

  func setNewTrackingType(newType: TrackingType) {
    trackingType = newType
  }

}
