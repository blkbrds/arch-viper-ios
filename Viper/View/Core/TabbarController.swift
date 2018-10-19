//
//  TabbarController.swift
//  Viper
//
//  Created by MBA0219 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift

final class TabbarController: UITabBarController {

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }

  // MARK: - Private method
  private func configureUI() {
    tabBar.setColors(
      background: R.color.tabbarBackground,
      selectedBackground: .clear,
      item: R.color.normalText,
      selectedItem: R.color.selectedItem
    )
  }
}
