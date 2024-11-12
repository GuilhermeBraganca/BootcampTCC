//
//  Track.swift
//  JaChegou
//
//  Created by MacBook on 18/08/24.
//

import Foundation

struct Track: Codable, Equatable {
    var image: String
    var description: String
    var trackingNumber: String
    var date: String
    var events = [Events]()

    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.trackingNumber == rhs.trackingNumber
    }
}


