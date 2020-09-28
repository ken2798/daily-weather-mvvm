
final class HomeController: UIViewController, BindableType {
    
    @IBOutlet private weak var toListCityButton: UIButton!
    @IBOutlet private weak var toWebViewButton: UIButton!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        let input = HomeViewModel.Input (toListCityTrigger: toListCityButton.rx.tap.asDriver(),
                                         toWebViewTrigger: toWebViewButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.toWebView
            .drive()
            .disposed(by: rx.disposeBag)
        output.toListCity
            .drive()
            .disposed(by: rx.disposeBag)
    }
}

extension HomeController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.home
}
