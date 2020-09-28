
protocol CurrentWeatherRepositoryType {
    func getCurrentWeather(coordinate: Coordinate) -> Observable<DataWeather>
}

final class CurrentWeatherRepository: CurrentWeatherRepositoryType {
    static let shared = CurrentWeatherRepository()
    
    func getCurrentWeather(coordinate: Coordinate) -> Observable<DataWeather> {
        let input = API.GetCurrentWeatherInput(lon: coordinate.lon, lat: coordinate.lat)
        return API.shared.getCurrentWeatherData(input)
    }
}
