

import UIKit

protocol ListCityNavigatorType {
    func toWeatherDetail(_ coordinate: Coordinate, namePlace: String)
    func back()
}

struct ListCityNavigator: ListCityNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toWeatherDetail(_ coordinate: Coordinate, namePlace: String) {
        let vc: WeatherDataController = assembler.resolve(navigationController: navigationController,
                                                          coordinate: coordinate, namePlace: namePlace)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
