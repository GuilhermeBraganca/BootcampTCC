//
//  ListViewModel.swift
//  JaChegou
//
//  Created by MacBook on 19/08/24.
//

import UIKit

class ListViewModel {
    
    private var TrackingList: [Track] = [Track(list: [Item(image: "TrackingImage", description: "Teste3", date: "66/66/6666"), Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste", date: "66/66/6666"),Item(image: "TrackingImage", description: "Teste2", date: "66/66/6666")])]
    
    private var CompleteTrackList: [Track] = [Track(list: [Item(image: "TrackingImage", description: "Teste3", date: "66/66/6666"), Item(image: "TrackingImage", description: "Teste", date: "66/66/6666")])]
    

    var numberOfRowsInSection: Int {
      return TrackingList.count
    }

    func loadCurrentDetail(indexPath: IndexPath) -> Track {
      return TrackingList[indexPath.row]
    }
    
}
