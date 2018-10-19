//
//  RColor.swift
//  Viper
//
//  Created by MBA0219 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension R.color {

  static let normalText = RGB(146, 146, 146)
  static let selectedItem = RGB(245, 124, 1)
  static let tabbarBackground = RGB(231, 231, 231)
  static let hightlightMinusText = RGB(255, 0, 78)
  static let hightlightPlusText = RGB(0, 255, 200)
  static let labelText = RGB(56, 56, 56)

  private static func RGB(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: CGFloat(alpha)
    )
  }

}
