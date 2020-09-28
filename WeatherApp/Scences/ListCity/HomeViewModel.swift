//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Bùi Xuân Huy on 7/2/20.
//  Copyright © 2020 huy. All rights reserved.
//

struct Region {
    var idRegion: Int
    var nameRegion: String
}

struct ListCityViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension ListCityViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let regionIndex: Driver<Int>
        let selectedCity: Driver<IndexPath>
        let toWebView: Driver<Void>
    }
    
    struct Output {
        let regionTitles: Driver<[String]>
        let listCity: Driver<[City]>
        let citySelected: Driver<Void>
        let selectedToWebView: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let listCity = input.regionIndex
            .flatMapLatest {
                self.useCase.getListCity(idRegion: $0)
                    .asDriverOnErrorJustComplete()
            }
        
        let regions = input.loadTrigger
            .flatMapLatest {
                self.useCase.getAllRegion()
                    .asDriverOnErrorJustComplete()
        }.map {
            $0.map { $0.nameRegion }
        }
        
        let citySelected = input.selectedCity
            .withLatestFrom(listCity) { indexPath, listCity in
                (listCity[indexPath.row].coordinate, listCity[indexPath.row].name)
            }
            .do(onNext: {
                self.navigator.toWeatherDetail($0.0, namePlace: $0.1)
            })
            .mapToVoid()
        let selectedToWebView = input.toWebView
            .do(onNext: navigator.toWebView)
            .mapToVoid()
        
        return Output(regionTitles: regions,
                      listCity: listCity,
                      citySelected: citySelected, selectedToWebView: selectedToWebView)
    }
}
