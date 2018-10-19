//
//  IDemoTradeView.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol DemoTradeView: class {
  var eventHandler: DemoTradeViewEventHandler? { get set }
  func update(with quote: Quote?)
  func update(with quotes: [Quote])
  func update(with profit: Profit)
  func showSettlement(action: TradeAction)
}

protocol DemoTradeViewEventHandler {
  func getQuote()
  func getProfitOrLossToday()
  func cancelGetQuote()
  func getQuoteHistory()
  func cancelGetQuoteHistory()
  func viewDidLoad()
  func showScreen(_ tradeView: TradeView, needPerform action: TradeView.Action)
}
