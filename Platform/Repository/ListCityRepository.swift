

protocol ListCityRepositoryType {
    func getAllCities(regionId: Int) -> Observable<[City]>
}

final class ListCityRepository: ListCityRepositoryType {
    static let shared = ListCityRepository()
    
    func getAllCities(regionId: Int) -> Observable<[City]> {
        return SQLiteService.shared.getAllCities(regionID: regionId)
    }
}
