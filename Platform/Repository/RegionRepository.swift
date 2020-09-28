

protocol RegionRepositoryType {
    func getAllCities(regionId: Int) -> Observable<[City]>
    func getAllRegion() -> Observable<[Region]>
}

final class RegionRepository: RegionRepositoryType {
    static let shared = RegionRepository()
    
    func getAllRegion() -> Observable<[Region]> {
        return SQLiteService.shared.getAllRegion()
    }
    
    func getAllCities(regionId: Int) -> Observable<[City]> {
        return SQLiteService.shared.getAllCities(regionID: regionId)
    }
}

