

protocol WeatherDataNavigatorType {
    func backToListCity()
}

struct WeatherDataNavigator: WeatherDataNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func backToListCity() {
        navigationController.popViewController(animated: true)
    }
}
