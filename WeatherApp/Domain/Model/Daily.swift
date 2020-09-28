

import ObjectMapper

struct Daily {
    var dt: Int
    var sunrise: Int
    var sunset: Int
    var temp: Temp
    var feelLike: FeelLike
    var pressure: Float
    var humidity: Float
    var dewPoint: Float
    var winSpeed: Float
    var windDeg: Float
    var weather: [Weather]
    var uvi: Float
    var clouds: Float
    var iconUrl: String {
        return API.APIUrl.imageUrl + (weather.first?.icon ??  "") + ".png"
    }
}

extension Daily {
    init() {
        self.init(dt: 0, sunrise: 0, sunset: 0, temp: Temp(), feelLike: FeelLike(), pressure: 0, humidity: 0, dewPoint: 0, winSpeed: 0, windDeg: 0, weather: [], uvi: 0, clouds: 0)
    }
}

extension Daily: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        dt <- map["dt"]
        sunrise <- map["sunrise"]
        sunset <- map["sunset"]
        temp <- map["temp"]
        feelLike <- map["feels_like"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
        dewPoint <- map["dew_point"]
        uvi <- map["uvi"]
        clouds <- map["clouds"]
        windDeg <- map["wind_deg"]
        winSpeed <- map["wind_speed"]
        weather <- map["weather"]
    }
}
