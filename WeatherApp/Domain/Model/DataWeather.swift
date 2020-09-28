

import ObjectMapper

struct DataWeather {
    var lat: Float
    var lon: Float
    var timeZone: String
    var timeZoneOffSet: Int
    var current: Current
    var hourly: [Hourly]
    var daily: [Daily]
}

extension DataWeather {
    init() {
        self.init(lat: 0, lon: 0, timeZone: "",
                  timeZoneOffSet: 0, current: Current(), hourly: [], daily: [])
    }
}

extension DataWeather: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        lat <- map["lat"]
        lon <- map["lon"]
        timeZone <- map["timezone"]
        timeZoneOffSet <- map["timezone_offset"]
        current <- map["current"]
        hourly <- map["hourly"]
        daily <- map["daily"]
    }
}
