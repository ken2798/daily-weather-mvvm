

import ObjectMapper

struct Main {
    var temp: Float
    var feelsLike: Float
    var tempMin: Float
    var tempMax: Float
    var pressure: Float
    var humidity: Float
}

extension Main {
    init() {
        self.init(temp: 0, feelsLike: 0,
                  tempMin: 0, tempMax: 0,
                  pressure: 0, humidity: 0)
    }
}

extension Main: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        temp <- map["temp"]
        feelsLike <- map["feels_like"]
        tempMin <- map["temp_min"]
        tempMax <- map["temp_max"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
}
