//
//  HttpServiceRouter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol HttpServiceRouter {

  var endpoint: String { get }
  var method: HTTPMethod { get }
  var path: String { get }
  var headers: [String: String]? { get }
  var parameters: Parameters? { get }
  var encoding: ParameterEncoding { get }

}
