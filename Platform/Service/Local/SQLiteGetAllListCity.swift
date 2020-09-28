
import FMDB

extension SQLiteService {
    func getAllCities(regionID: Int) -> Observable<[City]> {
        var cities = [City]()
        if let path = databasePath {
            let db = FMDatabase(path: path)
            let query = "SELECT * FROM " + Constant.listCityTableName + " WHERE " + Constant.regionIdColumn + " =\(regionID)"
            if db.open() {
                do {
                    let results = try db.executeQuery(query, values: nil)
                    while results.next() {
                        let city = City(name: results.string(forColumn: Constant.nameCityColum) ?? "",
                                        coordinate: Coordinate(Float(results.double(forColumn: Constant.lonColumn)),
                                                               Float(results.double(forColumn: Constant.latColumn))),
                                        region: Int(results.int(forColumn: Constant.regionIdColumn)))
                        cities.append(city)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        return Observable.from(optional: cities)
    }
}
