

import ObjectMapper

extension API {
    func getCurrentWeatherData(_ input: GetCurrentWeatherInput) -> Observable<DataWeather> {
        return request(input)
    }
}

extension API {
    final class GetCurrentWeatherInput: APIInput {
        init(lon: Float, lat: Float) {
            let params: JSONDictionary = [
                "lat": lat,
                "lon": lon,
                "lang": "vi",
                "units": "metric"
            ]
            super.init(urlString: APIUrl.baseUrl,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: false)
        }
    }
}

