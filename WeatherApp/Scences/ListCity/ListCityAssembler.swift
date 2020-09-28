

protocol ListCityAssembler {
    func resolve(navigationController: UINavigationController) -> ListCityController
    func resolve(navigationController: UINavigationController) -> ListCityViewModel
    func resolve(navigationController: UINavigationController) -> ListCityNavigatorType
    func resolve() -> ListCityUseCaseType
}

extension ListCityAssembler {
    func resolve(navigationController: UINavigationController) -> ListCityController {
        let vc = ListCityController.instantiate()
        let vm: ListCityViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> ListCityViewModel {
        return ListCityViewModel(navigator: resolve(navigationController: navigationController),
                             useCase: resolve())
    }
}

extension ListCityAssembler where Self: DefaultAsssembler {
    func resolve(navigationController: UINavigationController) -> ListCityNavigatorType {
        return ListCityNavigator(assembler: self,
                             navigationController: navigationController)
    }
    
    func resolve() -> ListCityUseCaseType {
        return ListCityUseCase(repository: resolve())
    }
}
