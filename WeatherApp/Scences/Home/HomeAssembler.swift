

protocol HomeAssembler {
    func resolve(navigationController: UINavigationController) -> HomeController
    func resolve(navigationController: UINavigationController) -> HomeViewModel
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType
    func resolve() -> HomeUseCaseType
}

extension HomeAssembler {
    func resolve(navigationController: UINavigationController) -> HomeController {
        let vc = HomeController.instantiate()
        let vm: HomeViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> HomeViewModel {
        return HomeViewModel(navigator: resolve(navigationController: navigationController),
                             useCase: resolve())
    }
}

extension ListCityAssembler where Self: DefaultAsssembler {
    func resolve(navigationController: UINavigationController) -> HomeNavigatorType {
        return HomeNavigator(assembler: self,
                             navigationController: navigationController)
    }
    
    func resolve() -> HomeUseCaseType {
        return HomeUseCase()
    }
}
