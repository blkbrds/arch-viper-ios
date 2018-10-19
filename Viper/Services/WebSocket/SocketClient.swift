//
//  SocketClient.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/27/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import SocketIO

typealias SocketData = SocketIO.SocketData
typealias SocketStatus = SocketIO.SocketIOStatus
typealias SocketClientEvent = SocketIO.SocketClientEvent

protocol SocketClient {
  // Socket's status stream.
  var status: SocketStatus { get }

  // Connect to socket server.
  func connect()
  // Connect to the server. If we aren’t connected after 30 seconds, then withHandler is called.
  func connect(completion: @escaping () -> Void)
  // Adds a handler for a client event.
  func on(event: SocketClientEvent, callback: @escaping NormalCallback) -> RequestHandler
  // Adds a handler for an event.
  func on(event: CustomStringConvertible, callback: @escaping NormalCallback) -> RequestHandler
  // Adds a single-use handler for a client event.
  func once(event: SocketClientEvent, callback: @escaping NormalCallback)
  // Adds a single-use handler for an event.
  func once(event: CustomStringConvertible, callback: @escaping NormalCallback)
  // Adds a handler for a client event.
  func on(clientEvent: SocketClientEvent, callback: @escaping NormalCallback)
  // Adds a single-use handler for a client event.
  func once(clientEvent: SocketClientEvent, callback: @escaping NormalCallback)
  // Send an event to the server, with optional data items.
  func emit(_ router: WsServiceRouter)
  // Sends a message to the server, requesting an ack.
  func emit(_ router: WsServiceRouter, timeout: Double, callback: @escaping AckCallback)
  // Disconnect from socket server.
  func disconnect()
}

final class DefaultSocketClient: SocketClient {

  private let manager: SocketManager

  init(manager: SocketManager = SocketManager.default) {
    self.manager = manager
  }

  var status: SocketStatus {
    return manager.defaultSocket.status
  }

  func connect() {
    let socket = manager.defaultSocket
    guard socket.status != .connected else { return }
    socket.on(clientEvent: .connect) { data, ack in
      // TODO: nothing to do now
    }
    socket.connect()
  }

  func connect(completion: @escaping () -> Void) {
    let socket = manager.defaultSocket
    guard socket.status != .connected else { return }
    socket.on(clientEvent: .connect) { data, ack in
      // TODO: nothing to do now
    }
    socket.connect(timeoutAfter: 30, withHandler: completion)
  }

  func on(event: SocketClientEvent, callback: @escaping NormalCallback) -> RequestHandler {
    let id = manager.defaultSocket.on(clientEvent: event, callback: callback)
    return SocketHandler(socket: manager.defaultSocket, id: id)
  }

  func on(event: CustomStringConvertible, callback: @escaping NormalCallback) -> RequestHandler {
    let id = manager.defaultSocket.on(event.description, callback: callback)
    return SocketHandler(socket: manager.defaultSocket, id: id)
  }

  func once(event: SocketClientEvent, callback: @escaping NormalCallback) {
    manager.defaultSocket.once(clientEvent: event, callback: callback)
  }

  func once(event: CustomStringConvertible, callback: @escaping NormalCallback) {
    manager.defaultSocket.once(event.description, callback: callback)
  }

  func on(clientEvent: SocketClientEvent, callback: @escaping NormalCallback) {
    manager.defaultSocket.on(clientEvent: clientEvent, callback: callback)
  }

  func once(clientEvent: SocketClientEvent, callback: @escaping NormalCallback) {
    manager.defaultSocket.once(clientEvent: clientEvent, callback: callback)
  }

  func emit(_ router: WsServiceRouter) {
    manager.defaultSocket.emit(router.event, router.data)
  }

  func emit(_ router: WsServiceRouter, timeout: Double = 30, callback: @escaping AckCallback) {
    manager.defaultSocket.emitWithAck(router.event, router.data).timingOut(after: 30, callback: callback)
  }

  func disconnect() {
    manager.defaultSocket.disconnect()
  }

}

extension SocketManager {
  static let `default`: SocketManager = {
    guard let url = URL(string: Config.WsApi.endpoint) else {
      fatalError("The Socket API endpoint is invalid")
    }
    return SocketManager(
      socketURL: url,
      config: [.log(false), .compress]
    )
  }()
}

struct SocketHandler {

  private let socket: SocketIOClient
  private let id: UUID

  init(socket: SocketIOClient, id: UUID) {
    self.socket = socket
    self.id = id
  }

  func off() {
    socket.off(id: id)
  }

}

extension SocketHandler: RequestHandler {
  func stop() {
    off()
  }
}
