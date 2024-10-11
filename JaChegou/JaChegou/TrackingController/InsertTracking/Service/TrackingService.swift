//
//  ExploreService.swift
//  AirbnbCloneBootcampProfessor
//
//  Created by Caio Fabrini on 18/09/24.
//

import Foundation

class TrackingService {

  static func fetchTrackingList(code: String, completion: @escaping (Result<[Events], NetworkError>) -> Void) {
    let request = APIRequest(url: "https://www.cepcerto.com/ws/encomenda-json/\(code)/91724a937ff068a37ca73a971e1cf13fa3fc5fe9")
    
    APIClient.shared.request(request: request, decodeType: [Events].self, completion: completion)
  }

}
