

protocol RepositoryAssembler {
    func resolve() -> CurrentWeatherRepositoryType
    func resolve() -> RegionRepositoryType
    func resolve() -> ListCityRepositoryType
}

extension RepositoryAssembler where Self: DefaultAsssembler {
    func resolve() -> CurrentWeatherRepositoryType {
        return CurrentWeatherRepository()
    }
    
    func resolve() -> RegionRepositoryType {
        return RegionRepository()
    }
    
    func resolve() -> ListCityRepositoryType {
        return ListCityRepository()
    }
}
