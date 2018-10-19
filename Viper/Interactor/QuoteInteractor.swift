//
//  QuoteInteractor.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol QuoteInteractor {
  func getQuote(_ param: GetQuoteParam) -> RequestHandler?
  func getQuoteHistory(_ param: GetQuoteHistoryParam) throws -> RequestHandler?
  var getQuoteResult: PublishSubject<Quote> { get }
  var getQuoteHistoryResult: PublishSubject<[Quote]> { get }
}

final class DefaultQuoteInteractor: QuoteInteractor {

  let getQuoteResult = PublishSubject<Quote>()
  let getQuoteHistoryResult = PublishSubject<[Quote]>()

  private let ws: WsQuoteService?
  private let http: HttpQuoteService?
  private let repository: QuoteRepository?

  init(
    ws: WsQuoteService? = DefaultWsQuoteService(),
    http: HttpQuoteService? = DefaultHttpQuoteService(),
    repository: QuoteRepository? = DefaultQuoteRepository()
  ) {
    self.ws = ws
    self.http = http
    self.repository = repository
  }

  func getQuote(_ param: GetQuoteParam) -> RequestHandler? {
    return ws?.getQuote(param) { [weak self] (res) in
      guard let self = self else { return }
      switch res {
      case .success(let entity):
        let quote = Quote(entity)
        self.getQuoteResult.onNext(quote)
      case .failure(let error):
        self.getQuoteResult.onError(error)
      }
    }
  }

  func getQuoteHistory(_ param: GetQuoteHistoryParam) throws -> RequestHandler? {
    return try http?.getQuoteHistory(param, callback: { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let value):
        let quotes = value.map({ (entity) -> Quote in
          return Quote(entity)
        })
        self.getQuoteHistoryResult.onNext(quotes)
      case .failure(let error):
        self.getQuoteHistoryResult.onError(error)
      }
    })
  }

}

// Data object for view rendering
final class Quote: JSONConvertible {

  let symbol: String
  let price: Double
  let bid: Double
  let ask: Double

  init(_ entity: QuoteEntity) {
    symbol = entity.symbol
    price = entity.price
    bid = entity.bid
    ask = entity.ask
  }

  func toJSON() -> [String: Any] {
    return [
      "symbol": symbol,
      "price": price,
      "bid": bid,
      "ask": ask
    ]
  }

}
