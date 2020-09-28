

protocol HomeNavigatorType {
    func toListCity()
    func toWebView()
}

struct HomeNavigator: HomeNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toListCity() {
        let listCityController: ListCityController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(listCityController, animated: true)
    }
    
    func toWebView() {
        let vc = WebViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
