//
//  ProfitLossInteracror.swift
//  Viper
//
//  Created by MBA0002 on 10/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol ProfitInteractor {
  func getProfitToday() -> RequestHandler?
  var getProfitTodayResult: PublishSubject<Profit> { get }
}

final class DefaultProfitInteractor: ProfitInteractor {

  let getProfitTodayResult = PublishSubject<Profit>()

  private let repository: ProfitRepository?

  init(repository: ProfitRepository? = DefaultProfitRepository()) {
    self.repository = repository
  }

  func getProfitToday() -> RequestHandler? {
    // TODO: - load profit/loss today from local db by repository
    return nil
  }
}

final class Profit: JSONConvertible {

  let value: Double

  init(value: Double) {
    self.value = value
  }

  func toJSON() -> [String: Any] {
    return [
      "value": value
    ]
  }
}
