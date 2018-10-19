//
//  WsConnectService.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/7/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol SocketService {
  func connect(_ param: ConnectionConnectParam, completion: @escaping (SocketStatus) -> Void)
}

final class DefaultSocketService: SocketService {

  private let client: SocketClient

  init(client: SocketClient = DefaultSocketClient()) {
    self.client = client
  }

  private var callback: ((SocketStatus) -> Void)?

  func connect(_ param: ConnectionConnectParam, completion: @escaping (SocketStatus) -> Void) {
    callback = completion
    _ = client.once(event: .connect, callback: { [weak self] (data, ack) in
      guard let self = self else { return }
      self.reply()
    })
    _ = client.once(event: .disconnect) { [weak self] (data, ack) in
      guard let self = self else { return }
      self.reply()
    }
    _ = client.once(event: WsAuthEvent.login.rawValue) { [weak self] (data, ack) in
      guard let self = self else { return }
      self.login(param)
    }
    _ = client.once(event: WsAuthEvent.loginSuccess.rawValue) { [weak self] (data, ack) in
      guard let self = self else { return }
      self.reply()
    }
    connect()
  }

  func connect() {
    client.connect()
  }

  private func login(_ param: ConnectionConnectParam) {
    let router = WsConnectionServiceRouter.login(param)
    client.emit(router)
  }

  private func reply() {
    callback?(client.status)
    callback = nil
  }

}

struct ConnectionConnectParam {
  let apiKey: String

  init(apiKey: String) {
    self.apiKey = apiKey
  }
}

enum WsConnectionServiceRouter: WsServiceRouter {

  case login(_ param: ConnectionConnectParam)

  var event: String {
    return "login"
  }

  var data: [SocketData] {
    switch self {
    case .login(let param):
      return [param.apiKey]
    }
  }

}

enum WsAuthEvent: String, CustomStringConvertible {
  case login = "login"
  case loginSuccess = "post_login_success"

  var description: String { return rawValue }
}
