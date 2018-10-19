//
//  HttpQuoteServiceRouter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

enum HttpQuoteServiceRouter: HttpServiceRouter {

  case getQuoteHistory(param: GetQuoteHistoryParam)

  var endpoint: String {
    return "http://localhost:9080/api/quotes"
  }

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    switch self {
    case .getQuoteHistory:
      return "/history"
    }
  }

  var headers: [String: String]? {
    return nil
  }

  var parameters: Parameters? {
    switch self {
    case .getQuoteHistory(let param):
      return param.toJSON()
    }
  }

  var encoding: ParameterEncoding {
    switch self {
    case .getQuoteHistory:
      return URLEncoding.default
    }
  }

}

struct GetQuoteHistoryParam: JSONConvertible {

  let pair: String
  let from: Date
  let to: Date

  init(pair: String, from: Date, to: Date) {
    self.pair = pair
    self.from = from
    self.to = to
  }

  func toJSON() -> [String: Any] {
    return [
      "pair": pair,
      "from": from.description,
      "to": to.description
    ]
  }

}
