

import ObjectMapper

struct FeelLike {
    var day: Float
    var night: Float
    var eve: Float
    var morn: Float
}

extension FeelLike {
    init() {
        self.init(day: 0, night: 0, eve: 0, morn: 0)
    }
}

extension FeelLike: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        day <- map["day"]
        night <- map["night"]
        eve <- map["eve"]
        morn <- map["morn"]
    }
}
