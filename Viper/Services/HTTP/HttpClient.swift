//
//  AlamofireRequetBuilder.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias Result = Alamofire.Result
typealias HTTPMethod = Alamofire.HTTPMethod
typealias Parameters = Alamofire.Parameters
typealias ParameterEncoding = Alamofire.ParameterEncoding
typealias URLEncoding = Alamofire.URLEncoding
typealias JSONEncoding = Alamofire.JSONEncoding

protocol HttpClient {
  func request(_ router: HttpServiceRouter) throws -> DataRequest
}

final class DefaultHttpClient: HttpClient {

  let manager: SessionManager

  init(manager: SessionManager = SessionManager.default) {
    self.manager = manager
  }

  func request(_ router: HttpServiceRouter) throws -> DataRequest {
    let url = try router.endpoint.asURL().appendingPathComponent(router.path)
    return manager.request(
      url,
      method: router.method,
      parameters: router.parameters,
      encoding: router.encoding,
      headers: router.headers
    )
  }

}

protocol JSONConvertible {
  func toJSON() -> [String: Any]
}

extension DataRequest: RequestHandler {
  func stop() {
    cancel()
  }
}
