

final class WeatherDataController: UIViewController, BindableType {
    
    @IBOutlet private weak var sunsetLabel: UILabel!
    @IBOutlet private weak var feelLikeLabel: UILabel!
    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var cloudLabel: UILabel!
    @IBOutlet private weak var uvIndexLabel: UILabel!
    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    @IBOutlet private weak var sunriseLabel: UILabel!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var dailyTableView: UITableView!
    @IBOutlet private weak var hourDataCollectionView: UICollectionView!
    @IBOutlet private weak var placeNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var desciptionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    private var hourLayoutInfo = CollectionViewLayout(itemSpacing: 7, itemsPerRow: 5)
    var viewModel: WeatherDataViewModel!
    let dateService = DateService.shared
    var dataWeather = DataWeather() {
        didSet {
            updateInfoNow(data: dataWeather)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        configFlowLayout(hourDataCollectionView, hourLayoutInfo)
        hourDataCollectionView.register(cellType: HourlyWeatherCell.self)
        dailyTableView.do {
            $0.register(cellType: DetailWeatherWeekCell.self)
            $0.rowHeight = 50
        }
    }
    
    private func configFlowLayout(_ collectionView: UICollectionView,
                                  _ collectionViewLayoutInfo: CollectionViewLayout) {
        let layout = UICollectionViewFlowLayout().then {
            let itemHeight = collectionView.height 
            let itemWitdh = collectionViewLayoutInfo.estimateWitdhPerItems()
            $0.itemSize = CGSize(width: itemWitdh, height: itemHeight)
            $0.minimumLineSpacing = collectionViewLayoutInfo.itemsSpacing
            $0.sectionInset = collectionViewLayoutInfo.sectionInset
            $0.scrollDirection = .horizontal
        }
        collectionView.collectionViewLayout = layout
    }
    
    func bindViewModel() {
        let input = WeatherDataViewModel.Input (loadTrigger: .just(()), backTrigger: backButton.rx.tap.asDriver())
        let output = viewModel.transform(input)
        output.nowInfomation
            .drive(self.rx.nowInfomation)
            .disposed(by: rx.disposeBag)
        
        output.namePlace
            .drive(placeNameLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.dateString
            .drive(dateLabel.rx.text)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.isRequestLoading
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)

        output.dataHour
            .drive(hourDataCollectionView.rx.items) { collectionview, index, items in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: HourlyWeatherCell = collectionview.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(data: items)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.dataDaily
            .drive(dailyTableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(item: index, section: 0)
                let cell: DetailWeatherWeekCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setContentForCell(data: item)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.back
            .drive()
            .disposed(by: rx.disposeBag)
    }
    
    func updateInfoNow(data: DataWeather) {
        
        temperatureLabel.text = "\(Int(data.current.temp))" + "º"
        desciptionLabel.text = data.current.weather.first?.description.capitalizingFirstLetter()
        iconImageView.rx.imageUrl.onNext(data.current.iconUrl)
        sunriseLabel.text = dateService.convertTimeStampToHourAndMinute(timeStamp: Double(data.current.sunrise))
        sunsetLabel.text = dateService.convertTimeStampToHourAndMinute(timeStamp: Double(data.current.sunset))
        feelLikeLabel.text = "\(data.current.feelsLike) º"
        humidityLabel.text = "\(data.current.humidity) %"
        windSpeedLabel.text = "\(data.current.winSpeed) km/h"
        pressureLabel.text = "\(data.current.pressure) hPa"
        cloudLabel.text = "\(data.current.clouds) %"
        uvIndexLabel.text = "\(data.current.uvi)"
    }
}

extension WeatherDataController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.weatherData
}

extension Reactive where Base: WeatherDataController {
    var nowInfomation: Binder<DataWeather> {
        return Binder(self.base) { vc, info in
            vc.dataWeather = info
        }
    }
}
