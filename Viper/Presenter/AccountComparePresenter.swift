//
//  AccountComparePresenter.swift
//  Viper
//
//  Created by MBA0219 on 10/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol AccountComparePresenter {
    // requirements
}

final class DefaultAccountComparePresenter: AccountComparePresenter, AccountCompareViewEventHandler {

    private weak var view: AccountCompareView?
    private let router: AccountCompareScreenRouter?

    init(view: AccountCompareView?, router: AccountCompareScreenRouter) {
        self.view = view
        self.router = router
    }

}
