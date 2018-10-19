//
//  HttpQuoteService.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/30/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol HttpQuoteService {
  func getQuoteHistory(_ param: GetQuoteHistoryParam, callback: @escaping (Result<[QuoteEntity]>) -> Void) throws -> RequestHandler
}

final class DefaultHttpQuoteService: HttpQuoteService {

  private let client: HttpClient

  init(client: HttpClient = DefaultHttpClient()) {
    self.client = client
  }

  func getQuoteHistory(_ param: GetQuoteHistoryParam, callback: @escaping (Result<[QuoteEntity]>) -> Void) throws -> RequestHandler {
    let router = HttpQuoteServiceRouter.getQuoteHistory(param: param)
    return try client.request(router).responseJSON(completionHandler: { (res) in
      switch res.result {
      case .success(let json):
        guard let json = json as? [[String: Any]] else { return }
        let quotes = json.compactMap { QuoteEntity(JSON: $0) }
        callback(Result<[QuoteEntity]>.success(quotes))
      case .failure(let error):
        callback(Result<[QuoteEntity]>.failure(error))
      }
    })
  }

}
