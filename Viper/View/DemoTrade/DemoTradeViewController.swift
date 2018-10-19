//
//  ViewController.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RxSwift

enum TradeAction {
  case buy
  case sell
}

final class DemoTradeViewController: UIViewController, DemoTradeView {

  // MARK: - DemoTradeView implementation
  var eventHandler: DemoTradeViewEventHandler?

  // MARK: - Outlets
  @IBOutlet weak var quoteGraphView: QuoteGraphView?
  @IBOutlet weak var tradeView: TradeView!

  // MARK: - Override functions
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    eventHandler?.viewDidLoad()
  }

  private func configureUI() {
    navigationItem.title = R.string.localized.demoTradeTitle()
    tradeView.delegate = self
    _ = eventHandler?.getProfitOrLossToday()
  }

  // MARK: - Actions
  @IBAction func graphTypeSegmentValueChanged() {
    // TODO: This should be call once
//    _ = eventHandler?.getQuoteHistory()
  }

  // MARK: - DemoTradeView implementation
  func update(with quote: Quote?) {
    guard let quote = quote else { return }
    let time = Date()
    let json = quote.toJSON()
    quoteGraphView?.infoLabel?.text = String(format: "\(time)\n\(json)")
    tradeView.updateView(with: quote)
  }

  func update(with quotes: [Quote]) {
    //
  }

  func update(with profit: Profit) {
    tradeView.updateView(with: profit)
  }

  func showSettlement(action: TradeAction) {
    tradeView.removeSubviews()
    let settlementView = SettlementView(frame: tradeView.bounds, action: action)
    tradeView.addSubview(settlementView)
  }
}

// MARK: - TradeViewDelegate
extension DemoTradeViewController: TradeViewDelegate {
  func tradeView(_ subview: TradeView, needPerform action: TradeView.Action) {
    eventHandler?.showScreen(subview, needPerform: action)
  }
}
