

import ObjectMapper

struct Hourly {
    var dt: Int
    var temp: Float
    var feelsLike: Float
    var pressure: Float
    var humidity: Float
    var dewPoint: Float
    var uvi: Float
    var clouds: Float
    var visibility: Float
    var winSpeed: Float
    var windDeg: Float
    var weather: [Weather]
    var iconUrl: String {
        return API.APIUrl.imageUrl + (weather.first?.icon ??  "") + ".png"
    }
}

extension Hourly {
    init() {
        self.init(dt: 0, temp: 0,
                  feelsLike: 0, pressure: 0,
                  humidity: 0, dewPoint: 0,
                  uvi: 0, clouds: 0,
                  visibility: 0, winSpeed: 0,
                  windDeg: 0, weather: [])
    }
}

extension Hourly: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        dt <- map["dt"]
        temp <- map["temp"]
        feelsLike <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dewPoint <- map["dew_point"]
        uvi <- map["uvi"]
        visibility <- map["visibility"]
        clouds <- map["clouds"]
        windDeg <- map["wind_deg"]
        winSpeed <- map["wind_speed"]
        weather <- map["weather"]
    }
}
