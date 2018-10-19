//
//  TradeViewPresenter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift
import SVProgressHUD

protocol DemoTradePresenter {
  // requirements
  func updateView()
  func updateView(with quote: Quote?)
  func updateView(with quotes: [Quote])
  func update(with profit: Profit)
  func showError(_ error: Error)
}

final class DefaultDemoTradePresenter: DemoTradePresenter, DemoTradeViewEventHandler {

  private let disposeBag = DisposeBag()

  private weak var view: DemoTradeView?
  private let router: DemoTradeScreenRouter?
  private let quoteInteractor: QuoteInteractor?
  private let socketInteractor: SocketInteractor?
  private let profitLossInteractor: ProfitInteractor?

  private var symbol = "USDJPY"

  private func subscibeInteractors() {
    quoteInteractor?
      .getQuoteResult
      .subscribe(
        onNext: { [weak self] (quote) in
          guard let self = self else { return }
          self.updateView(with: quote)
        }, onError: { [weak self] (error) in
          guard let self = self else { return }
          self.showError(error)
        }, onCompleted: { [weak self] () in
          guard let self = self else { return }
          self.dismissHUD()
        }, onDisposed: {
          print("QuoteInteractor.getQuoteResult disposed.")
        }
      ).disposed(by: disposeBag)

    socketInteractor?
      .status
      .subscribe(onNext: { [weak self] (status) in
        guard let self = self else { return }
        print("Socket status: \(status.description)")
        guard status == .connected else { return }
        self.getQuote()
      }).disposed(by: disposeBag)

    // TODO: - subcribe interactors with profitLossInteractor
  }

  init(
    view: DemoTradeView?,
    router: DemoTradeScreenRouter?,
    quoteInteractor: QuoteInteractor? = DefaultQuoteInteractor(),
    socketInteractor: SocketInteractor? = DefaultSocketInteractor(),
    profitLossInteractor: ProfitInteractor? = DefaultProfitInteractor()
  ) {
    self.view = view
    self.router = router
    self.quoteInteractor = quoteInteractor
    self.socketInteractor = socketInteractor
    self.profitLossInteractor = profitLossInteractor
    subscibeInteractors()
  }

  var getQuoteRequest: RequestHandler?

  func getQuote() {
    let param = GetQuoteParam(symbol: symbol)
    getQuoteRequest = quoteInteractor?.getQuote(param)
  }

  func cancelGetQuote() {
    getQuoteRequest?.stop()
  }

  var getQuoteHistoryRequest: RequestHandler?

  func getQuoteHistory() {
    let to = Date()
    let from = to.addingTimeInterval(-30)
    let param = GetQuoteHistoryParam(pair: symbol, from: from, to: to)
    do {
      getQuoteHistoryRequest = try quoteInteractor?.getQuoteHistory(param)
    } catch {
      showError(error)
    }
  }

  func getProfitOrLossToday() {
    // TODO: - load profit/loss today from local db by profitLossInteractor
    #warning ("delete code below - it just mock data")
    view?.update(with: Profit(value: -123.324))
  }

  func cancelGetQuoteHistory() {
    getQuoteHistoryRequest?.stop()
  }

  func viewDidLoad() {
    socketInteractor?.connect()
  }

  func updateView() {
    // update view with current data
  }

  func updateView(with quote: Quote?) {
    view?.update(with: quote)
  }

  func updateView(with quotes: [Quote]) {
    view?.update(with: quotes)
  }

  func update(with profit: Profit) {
    view?.update(with: profit)
  }

  func showScreen(_ tradeView: TradeView, needPerform action: TradeView.Action) {
    switch action {
    case .buy:
      view?.showSettlement(action: .buy)
    case .sell:
      view?.showSettlement(action: .sell)
    case .encourage:
      router?.showScreen(.encourage)
    }
  }

  func showError(_ error: Error) {
    router?.showError(error)
  }

  func showHUD() {
    SVProgressHUD.show()
  }

  func dismissHUD() {
    SVProgressHUD.dismiss()
  }

}
