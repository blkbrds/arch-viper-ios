//
//  Router.swift
//  Viper
//
//  Created by Dao Nguyen V. on 10/3/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol ScreenRouter {
  associatedtype View: UIViewController
  var viewController: View? { get set } // weak
  func showError(_ error: Error)
}

extension ScreenRouter {
  func showError(_ error: Error) {
    let alert = UIAlertController(title: "ERROR", message: error.localizedDescription, preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .cancel)
    alert.addAction(ok)
    viewController?.present(alert, animated: true, completion: nil)
  }
}
