
import ObjectMapper

struct Temp {
    var day: Float
    var min: Float
    var max: Float
    var night: Float
    var eve: Float
    var morn: Float
}

extension Temp {
    init() {
        self.init(day: 0, min: 0, max: 0, night: 0, eve: 0, morn: 0)
    }
}

extension Temp: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        day <- map["day"]
        min <- map["min"]
        max <- map["max"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }
}
