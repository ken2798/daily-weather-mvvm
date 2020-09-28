


protocol ListCityUseCaseType {
    func getAllRegion() -> Observable<[Region]>
    func getListCity(idRegion: Int) -> Observable<[City]>
}

struct ListCityUseCase: ListCityUseCaseType {
    let repository: RegionRepositoryType
    
    func getAllRegion() -> Observable<[Region]> {
        return repository.getAllRegion()
    }
    
    func getListCity(idRegion: Int) -> Observable<[City]> {
        return repository.getAllCities(regionId: idRegion)
    }
}
