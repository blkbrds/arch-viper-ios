//
//  TabbarRouter.swift
//  Viper
//
//  Created by MBA0219 on 10/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class TabbarScreenRouter: ScreenRouter {
    // MARK: - Enum
    enum TabbarItem: Int {
        case demoTrade = 0
        case accountCompare
        case performance
    }

    enum Screen: String {
        case demoTrade = "DemoTrade"
        case accountCompare = "AccountCompare"
        case performance = "Performance"
    }

    // MARK: - Propertie
    weak var viewController: TabbarController?

    // MARK: - Public Method
    func showScreen(_ screen: Screen) {
        switch screen {
        case .demoTrade:
            print("selected :", screen)
            viewController?.selectedIndex = 1
        case .accountCompare:
            print("selected :", screen)
        case .performance:
            print("selected :", screen)
        }
    }

    func configDefaultTabbarController() {
        // init demotrade
        let demotradeVC = demoTradeViewController()
        let demotradeNavi = NavigationController(rootViewController: demotradeVC)
        demotradeNavi.tabBarItem = UITabBarItem(title: R.string.localized.demoTrade(),
                                                image: R.image.icTabbarTrade(),
                                                tag: 0)
        // init accountCompare
        let accountCompareVC = accountCompareViewController()
        let accountCompareNavi = NavigationController(rootViewController: accountCompareVC)
        accountCompareNavi.tabBarItem = UITabBarItem(title: R.string.localized.accountCompare(),
                                                     image: R.image.icTabbarCompare(),
                                                     tag: 1)
        // init performance
        let performanceVC = performanceViewController()
        let performanceNavi = NavigationController(rootViewController: performanceVC)
        performanceNavi.tabBarItem = UITabBarItem(title: R.string.localized.performance(),
                                                  image: R.image.icTabbarAvatar(),
                                                  tag: 2)

        // array viewcontrollers for tabbar
        let viewControllers: [UIViewController] = [demotradeNavi, accountCompareNavi, performanceNavi]

        // set viewControllers
        viewController?.viewControllers = viewControllers
    }

    // MARK: - Private method
    private func demoTradeViewController() -> DemoTradeViewController {
        let viewController = DemoTradeViewController()
        let router = DemoTradeScreenRouter()
        router.viewController = viewController
        let presenter = DefaultDemoTradePresenter(view: viewController, router: router)
        viewController.eventHandler = presenter
        return viewController
    }

    private func accountCompareViewController() -> AccountCompareViewController {
        let viewController = AccountCompareViewController()
        let router = AccountCompareScreenRouter()
        router.viewController = viewController
        let presenter = DefaultAccountComparePresenter(view: viewController, router: router)
        viewController.eventHandler = presenter
        return viewController
    }

    private func performanceViewController() -> PerformanceViewController {
        let viewController = PerformanceViewController()
        let router = PerformanceScreenRouter()
        router.viewController = viewController
        let presenter = DefaultPerformancePresenter(view: viewController, router: router)
        viewController.eventHandler = presenter
        return viewController
    }
}
