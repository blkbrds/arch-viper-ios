//
//  SettingsView.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol SettingsView: class {
  var eventHandler: SettingsViewEventHandler? { get set }
}

protocol SettingsViewEventHandler {
  // requirements
}
