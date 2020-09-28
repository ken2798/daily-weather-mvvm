

struct HourWeatherData {
    var hour: String
    var icon: String
    var temp: String
}

struct DailyWeatherData {
    var day: String
    var icon: String
    var temp: String
}

struct WeatherDataViewModel {
    let useCase: WeatherDataUseCaseType
    let navigator: WeatherDataNavigatorType
    let coordinate: Coordinate
    let namePlace: String
}

extension WeatherDataViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let backTrigger: Driver<Void>
    }
    
    struct Output {
        let nowInfomation: Driver<DataWeather>
        let namePlace: Driver<String>
        let error: Driver<Error>
        let isRequestLoading: Driver<Bool>
        let dateString: Driver<String>
        let dataHour: Driver<[HourWeatherData]>
        let dataDaily: Driver<[DailyWeatherData]>
        let back: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        let dateService = DateService.shared
        let namePlace = Driver.just(self.namePlace)
        let dateString = Driver.just(dateService.convertedToVietnameseDate(date: Date()))
        let dataHour = BehaviorRelay<[HourWeatherData]>(value: [])
        let dataDaily = BehaviorRelay<[DailyWeatherData]>(value: [])
        
        let currentInfomation = input.loadTrigger
            .flatMapLatest {
                self.useCase.getWeatherData(coordinate: self.coordinate)
                    .trackError(error)
                    .trackActivity(indicator)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: {
                let hourData = $0.hourly.map {
                    HourWeatherData(hour: dateService.convertTimeStampToHour(timeStamp: Double($0.dt)),
                                    icon: $0.iconUrl,
                                    temp: "\(Int($0.temp))º")
                }
                let dailyData = $0.daily.map {
                    DailyWeatherData(day: dateService.convertedToVietnameseDayDate(timeStamp: Double($0.dt)),
                                     icon: $0.iconUrl ,
                                     temp: "\(Int($0.temp.min))º - \(Int($0.temp.max))º")
                }
                dataHour.accept(hourData.takeElements(elementCount: 20))
                dataDaily.accept(Array(dailyData.suffix(from: 1)))
            })
        
        let back = input.backTrigger
            .do(onNext: navigator.backToListCity)
            .mapToVoid()
            
        return Output(nowInfomation: currentInfomation,
                      namePlace: namePlace,
                      error: error.asDriver(),
                      isRequestLoading: indicator.asDriver(),
                      dateString: dateString,
                      dataHour: dataHour.asDriver(),
                      dataDaily: dataDaily.asDriver(),
                      back: back)
    }
}


