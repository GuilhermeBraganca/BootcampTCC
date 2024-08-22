//
//  TrackingDetailTableViewCell.swift
//  JaChegou
//
//  Created by MacBook on 19/08/24.
//

import UIKit

class TrackingDetailTableViewCell {

    private var track: Track?

    func setTrack(track: Track) {
      self.track = track
    }
    
    var numberOfItemsInSection: Int {
      return track?.list.count ?? 0
    }

    func loadCurrentItem(indexPath: IndexPath) -> Item {
      return track?.list[indexPath.row] ?? Item(image: "", description: "", date: "")
    }
}
