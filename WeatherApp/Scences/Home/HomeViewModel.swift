

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModelType {
    struct Input {
        let toListCityTrigger: Driver<Void>
        let toWebViewTrigger: Driver<Void>
    }
    
    struct Output {
        let toListCity: Driver<Void>
        let toWebView: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toListCity = input.toListCityTrigger
            .do(onNext: navigator.toListCity)
        
        let toWebView = input.toWebViewTrigger
            .do(onNext: navigator.toWebView)
        
        return Output(toListCity: toListCity, toWebView: toWebView)
    }
}
