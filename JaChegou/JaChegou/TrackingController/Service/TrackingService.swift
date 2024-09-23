//
//  ExploreService.swift
//  AirbnbCloneBootcampProfessor
//
//  Created by Caio Fabrini on 18/09/24.
//

import Foundation

class TrackingService {

  static func fetchTrackingList(completion: @escaping (Result<[TrackingInfoResponse], NetworkError>) -> Void) {
    let request = APIRequest(url: "https://www.cepcerto.com/ws/encomenda-json/NM455753071BR/91724a937ff068a37ca73a971e1cf13fa3fc5fe9")

    // Nesse caso podemos fazer de 2 formas

    // 1 -> mais simples o entendimento, porem retornando o mesmo que o outro completion
    //    APIClient.shared.request(request: request, decodeType: [TravelCategory].self) { result in
    //      switch result {
    //      case .success(let success):
    //        completion(.success(success))
    //      case .failure(let failure):
    //        completion(.failure(failure))
    //      }
    //    }

    // 2 -> bem mais difícil o entendimento, porem economizando bastante linhas desnecessárias!
    APIClient.shared.request(request: request, decodeType: [TrackingInfoResponse].self, completion: completion)
  }

}
