

import ObjectMapper

struct Wind {
    var speed: Float
    var deg: Float
}

extension Wind {
    init() {
        self.init(speed: 0, deg: 0)
    }
}

extension Wind: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
}
