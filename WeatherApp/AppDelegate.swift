

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var assembler: Assembler = DefaultAsssembler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        bindViewModel()
        return true
    }
    
    private func bindViewModel() {
        guard let window = window else { return }
        
        let viewModel: AppViewModel = assembler.resolve(window: window)
        let input = AppViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.toHomeScreen
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

