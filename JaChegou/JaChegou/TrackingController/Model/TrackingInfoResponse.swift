//
//  TrackingModel.swift
//  JaChegou
//
//  Created by Fabio Cristiano Lopes on 14/09/24.
//

import Foundation

// Data Transfer Object
struct TrackingDTO: Codable {
  var code: String
  var description: String
  var trackingList: [TrackingInfoResponse]
}

struct TrackingInfoResponse: Codable {
    var data: String?
    var descricao: String?
    var unidade: String?
    var cidade: String?
    var uf: String?
}
