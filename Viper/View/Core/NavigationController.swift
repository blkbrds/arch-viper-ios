//
//  NavigationController.swift
//  Viper
//
//  Created by MBA0219 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = false
    }
}
