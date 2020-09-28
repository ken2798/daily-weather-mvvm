

final class ListCityController: UIViewController, BindableType {
    
    // MARK: - Outlets
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var segmentControl: HBSegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    var viewModel: ListCityViewModel!
    var regionsTitle: [String] = [] {
        didSet {
            segmentControl.items = regionsTitle
        }
    }
    var regionTrigger = BehaviorRelay<Int>(value: 1)
    
    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        tableView.do {
            $0.register(cellType: ListCityCell.self)
            $0.rowHeight = $0.frame.height / 10
            $0.delegate = self
        }

        segmentControl.do {
            $0.font = UIFont(name: "Myriad Pro", size: 16)
            $0.borderColor = UIColor(white: 1.0, alpha: 0.3)
            $0.selectedIndex = 0
            $0.padding = 4
            $0.addTarget(self,
                         action: #selector(segmentValueChanged(_:)),
                                     for: .valueChanged)
        }
    }
    
    @objc func segmentValueChanged(_ sender: AnyObject?){
        if segmentControl.selectedIndex == 0 {
            regionTrigger.accept(1)
        } else if segmentControl.selectedIndex == 1 {
            regionTrigger.accept(2)
        } else {
            regionTrigger.accept(3)
        }
    }
    
    func bindViewModel() {
        let input = ListCityViewModel.Input(
            loadTrigger: .just(()),
            regionIndex: regionTrigger.asDriverOnErrorJustComplete(),
            selectedCity: tableView.rx.itemSelected.asDriver(), toWebView: backButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.regionTitles
            .drive(self.rx.titleSegment)
            .disposed(by: rx.disposeBag)
        
        output.listCity
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: ListCityCell = tableView.dequeueReusableCell(for: indexPath)
                cell.configCell(nameCity: item.name)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.citySelected
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.selectedToWebView.drive().disposed(by: rx.disposeBag)
    }
}

extension ListCityController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.listCity
}

extension ListCityController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.6509803922, blue: 0.9176470588, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension Reactive where Base: ListCityController {
    var titleSegment: Binder<[String]> {
        return Binder(self.base) { vc, titles in
            vc.regionsTitle = titles
        }
    }
}
