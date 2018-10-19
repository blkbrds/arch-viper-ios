//
//  AppDelegate.swift
//  Viper
//
//  Created by Dao Nguyen V. on 9/26/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var router: RootScreenRouter?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    let router = RootScreenRouter()
    router.window = window
    router.showScreen(.tabbar)
    self.router = router
    window?.makeKeyAndVisible()
    return true
  }

}
