

protocol WeatherDataAssembler {
    func resolve(navigationController: UINavigationController, coordinate: Coordinate,
                 namePlace: String) -> WeatherDataController
    func resolve(navigationController: UINavigationController, coordinate: Coordinate,
                 namePlace: String) -> WeatherDataViewModel
    func resolve(navigationController: UINavigationController) -> WeatherDataNavigatorType
    func resolve() -> WeatherDataUseCaseType
}

extension WeatherDataAssembler {
    func resolve(navigationController: UINavigationController, coordinate: Coordinate, namePlace: String) -> WeatherDataController {
        let vc = WeatherDataController.instantiate()
        let vm: WeatherDataViewModel = resolve(navigationController: navigationController,
                                            coordinate: coordinate, namePlace: namePlace)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController, coordinate: Coordinate, namePlace: String) -> WeatherDataViewModel {
        return WeatherDataViewModel(useCase: resolve(),
                                 navigator: resolve(navigationController: navigationController),
                                 coordinate: coordinate, namePlace: namePlace)
    }
}

extension WeatherDataAssembler where Self:  DefaultAsssembler {
    func resolve(navigationController: UINavigationController) -> WeatherDataNavigatorType {
        return WeatherDataNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> WeatherDataUseCaseType {
        return WeatherDataUseCase(repository: resolve())
    }
}
