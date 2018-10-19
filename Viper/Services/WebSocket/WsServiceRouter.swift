//
//  WsServiceRouter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/7/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol WsServiceRouter {
  var event: String { get }
  var data: [SocketData] { get }
}
