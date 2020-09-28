

protocol WeatherDataUseCaseType {
    func getWeatherData(coordinate: Coordinate) -> Observable<DataWeather>
}

struct WeatherDataUseCase: WeatherDataUseCaseType {
    let repository: CurrentWeatherRepositoryType
    
    func getWeatherData(coordinate: Coordinate) -> Observable<DataWeather> {
        return repository.getCurrentWeather(coordinate: coordinate)
    }
}

