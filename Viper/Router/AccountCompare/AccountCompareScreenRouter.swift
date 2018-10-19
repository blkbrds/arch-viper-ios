//
//  AccountCompareScreenRouter.swift
//  Viper
//
//  Created by MBA0219 on 10/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class AccountCompareScreenRouter: ScreenRouter {
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
