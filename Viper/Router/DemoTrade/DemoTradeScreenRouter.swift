//
//  QuoteScreenRouter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class DemoTradeScreenRouter: ScreenRouter {

  enum Screen: String {
    case buy = "Buy"
    case sell = "Sell"
    case encourage = "Encourage"
  }

  weak var viewController: UIViewController?

  func showScreen(_ screen: Screen) {
    switch screen {
    case .encourage:
        let target = accountCompareViewController()
        viewController?.navigationController?.pushViewController(target, animated: true)
    default: break
    }
  }

  private func accountCompareViewController() -> AccountCompareViewController {
    let viewController = AccountCompareViewController()
    let router = AccountCompareScreenRouter()
    router.viewController = viewController
    let presenter = DefaultAccountComparePresenter(view: viewController, router: router)
    viewController.eventHandler = presenter
    return viewController
  }
}
