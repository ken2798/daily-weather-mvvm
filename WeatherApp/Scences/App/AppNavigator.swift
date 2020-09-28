

import UIKit

protocol AppNavigatorType {
    func toHomeScreen()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toHomeScreen() {
        let navigationController = UINavigationController().then {
            $0.navigationBar.isHidden = true
        }
        let homeController: HomeController = assembler.resolve(navigationController: navigationController)
        navigationController.viewControllers.append(homeController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
