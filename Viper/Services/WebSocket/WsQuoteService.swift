//
//  QuoteService.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

struct GetQuoteParam {

  let symbol: String

  init(symbol: String) {
    self.symbol = symbol
  }

}

protocol WsQuoteService {
  func getQuote(_ param: GetQuoteParam, callback: @escaping (Result<QuoteEntity>) -> Void) -> RequestHandler
}

final class DefaultWsQuoteService: WsQuoteService {

  private let client: SocketClient

  init(socket: SocketClient = DefaultSocketClient()) {
    self.client = socket
  }

  func getQuote(_ param: GetQuoteParam, callback: @escaping (Result<QuoteEntity>) -> Void) -> RequestHandler {
    let router = WsQuoteServiceRouter.getQuote(param)
    let handler = client.on(event: WsQuoteEvent.getQuoteResult) { (data, ack) in
      print("\(data)")
      data.compactMap { $0 as? [String: Any] }
        .compactMap { QuoteEntity(JSON: $0) }
        .forEach { callback(Result<QuoteEntity>.success($0)) }
    }
    client.emit(router)
    return handler
  }

}

enum WsQuoteServiceRouter: WsServiceRouter {

  case getQuote(_ param: GetQuoteParam)

  var event: String {
    switch self {
    case .getQuote:
      return "rooms"
    }
  }

  var data: [SocketData] {
    switch self {
    case .getQuote(let param):
      return [param.symbol]
    }
  }

}

enum WsQuoteEvent: String, CustomStringConvertible {
  case getQuoteResult = "broadcast"

  var description: String { return rawValue }
}
