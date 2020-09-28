//
//  HomeNavigator.swift
//  WeatherApp
//
//  Created by Bùi Xuân Huy on 7/2/20.
//  Copyright © 2020 huy. All rights reserved.
//

import UIKit

protocol ListCityViewModelType {
    func toWeatherDetail(_ coordinate: Coordinate, namePlace: String)
    func toWebView()
}

struct ListCityNavigator: ListCityViewModelType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toWeatherDetail(_ coordinate: Coordinate, namePlace: String) {
        let vc: WeatherDataController = assembler.resolve(navigationController: navigationController,
                                                          coordinate: coordinate, namePlace: namePlace)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toWebView() {
        let vc = WebViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
    }
}
