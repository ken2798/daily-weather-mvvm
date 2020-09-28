

import FMDB

extension SQLiteService {
    struct Constant {
        static let regionTableName = "Region"
        static let regionIdColumn = "regionId"
        static let regionNameColumn = "regionName"
        static let listCityTableName = "LISTCITY"
        static let idCityColumn = "idCity"
        static let nameCityColum = "nameCity"
        static let latColumn = "lat"
        static let lonColumn = "lon"
    }
    
    func getAllRegion() -> Observable<[Region]> {
        var regions = [Region]()
        if let path = databasePath {
            let db = FMDatabase(path: path)
            let query = "SELECT * FROM " + Constant.regionTableName
            if db.open() {
                do {
                    let results = try db.executeQuery(query, values: nil)
                    while results.next() {
                        if let name = results.string(forColumn: Constant.regionNameColumn) {
                            let region = Region(idRegion: Int(results.int(forColumn: Constant.regionIdColumn)),
                                                nameRegion: name)
                            regions.append(region)
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return Observable.from(optional: regions)
    }
}
