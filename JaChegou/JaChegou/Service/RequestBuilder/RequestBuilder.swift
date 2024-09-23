//
//  RequestBuilder.swift
//  TudoSobreCamadaDeNetwork
//
//  Created by Caio Fabrini on 16/09/24.
//

import Foundation

protocol RequestBuilder {
  func buildRequest(request: APIRequest, baseURL: String, timeout: TimeInterval) -> URLRequest?
}

struct DefaultRequestBuilder: RequestBuilder {
  func buildRequest(request: APIRequest, baseURL: String, timeout: TimeInterval) -> URLRequest? {
    let completeURLString: String = baseURL + request.url

    guard let url = URL(string: completeURLString) else { return nil }

    var completeRequest = URLRequest(url: url)
    completeRequest.httpMethod = request.method.rawValue
    completeRequest.allHTTPHeaderFields = request.headers
    completeRequest.timeoutInterval = timeout

    if let parameters = request.parameters {
      switch parameters {
      case .dictionary(let dictionary):
        completeRequest.httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
      case .encodable(let encodable):
        completeRequest.httpBody = try? JSONEncoder().encode(encodable)
      }
    }

    return completeRequest
  }
}
