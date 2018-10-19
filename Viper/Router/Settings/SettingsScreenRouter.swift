//
//  SettingsScreenRouter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/4/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class SettingsScreenRouter: ScreenRouter {

  enum Screen: String {
    case info = "Info"
  }

  weak var viewController: UIViewController?

  func showScreen(_ screen: Screen) {
    switch screen {
    case .info:
      break
    }
  }

}
