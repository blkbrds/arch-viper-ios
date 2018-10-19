//
//  Quote.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class QuoteEntity: ImmutableMappable {

  var symbol: String = ""
  var price: Double = 0
  var bid: Double = 0
  var ask: Double = 0

  init(map: Map) {
    symbol <- map["symbol"]
    price <- map["price"]
    bid <- map["bid"]
    ask <- map["ask"]
  }

}
