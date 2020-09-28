

import ObjectMapper

struct Coord {
    var lon: Float
    var lat: Float
}

extension Coord {
    init() {
        self.init(lon: 0, lat: 0)
    }
}

extension Coord: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        lon <- map["lon"]
        lat <- map["lat"]
    }
}
