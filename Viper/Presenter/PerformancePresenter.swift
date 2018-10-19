//
//  PerformancePresenter.swift
//  Viper
//
//  Created by MBA0219 on 10/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol PerformancePresenter {
    // requirements
}

final class DefaultPerformancePresenter: PerformancePresenter, PerformanceViewEventHandler {

    private weak var view: PerFormanceView?
    private let router: PerformanceScreenRouter?

    init(view: PerFormanceView?, router: PerformanceScreenRouter) {
        self.view = view
        self.router = router
    }

}
