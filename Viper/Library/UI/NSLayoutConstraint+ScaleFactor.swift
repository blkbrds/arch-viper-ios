//
//  NSLayoutConstraintExtension.swift
//  Viper
//
//  Created by MBA0219 on 10/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

  enum Direction {
    case horizontal
    case vertical
  }

  func scale(by direction: Direction) {
    switch direction {
    case .horizontal:
      constant *= ScaleFactor.horizontal
    case .vertical:
      constant *= ScaleFactor.vertical
    }
  }

}
