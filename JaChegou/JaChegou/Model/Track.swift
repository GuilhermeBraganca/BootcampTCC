//
//  Track.swift
//  JaChegou
//
//  Created by MacBook on 18/08/24.
//

import Foundation


struct Track {
    var image: String
    var description: String
    var date: String
    var events = [Events]()
}


struct Events {
    var event: String
    var date: String
}
