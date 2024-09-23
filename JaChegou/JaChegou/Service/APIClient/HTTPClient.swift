//
//  HTTPClient.swift
//  TudoSobreCamadaDeNetwork
//
//  Created by Caio Fabrini on 16/09/24.
//

import Foundation

protocol HTTPClient {
  // Forma generica
  func request<T: Decodable>(request: APIRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)

  // Tipagem fixa
  // func request(request: APIRequest, decodeType: User.self, completion: @escaping (Result<User, NetworkError>) -> Void)
}
