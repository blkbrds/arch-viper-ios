//
//  AccountCompareViewController.swift
//  Viper
//
//  Created by MBA0219 on 10/9/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class AccountCompareViewController: UIViewController, AccountCompareView {

    var eventHandler: AccountCompareViewEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = R.string.localized.accountCompareTitle()
    }
}
