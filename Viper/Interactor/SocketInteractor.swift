//
//  SocketInteractor.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/8/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol SocketInteractor {
  var status: BehaviorRelay<SocketStatus> { get }
  func connect()
}

final class DefaultSocketInteractor: SocketInteractor {

  let status = BehaviorRelay<SocketStatus>(value: .notConnected)

  private let ws: SocketService

  init(ws: SocketService = DefaultSocketService()) {
    self.ws = ws
  }

  func connect() {
    // TODO: Move ApiKey to Configuration file
    let param = ConnectionConnectParam(apiKey: "")
    ws.connect(param) { [weak self] (status) in
      guard let self = self else { return }
      self.status.accept(status)
    }
  }

}
