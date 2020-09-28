

import MGArchitecture

struct AppViewModel {
    var useCase: AppUseCaseType
    var navigator: AppNavigatorType
}

extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toHomeScreen: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toHomeScreen = input.loadTrigger
            .do(onNext: self.navigator.toHomeScreen)
        return Output(toHomeScreen: toHomeScreen)
    }
}
