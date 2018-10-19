//
//  SettingsPresenter.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol SettingsPresenter {
  // requirements
}

final class DefaultSettingsPresenter: SettingsPresenter, SettingsViewEventHandler {

  private weak var view: SettingsView?
  private let router: SettingsScreenRouter?

  init(view: SettingsView?, router: SettingsScreenRouter) {
    self.view = view
    self.router = router
  }

}
