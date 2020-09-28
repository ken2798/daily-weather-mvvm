

import ObjectMapper

struct WeatherItem {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

extension WeatherItem {
    init() {
        self.init(id: 0, main: "", description: "", icon: "")
    }
}

extension WeatherItem: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}

struct Weather {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

extension Weather {
    init() {
        self.init(id: 0, main: "", description: "", icon: "")
    }
}

extension Weather: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        description <- map["description"]
        icon <- map["icon"]
    }
}
