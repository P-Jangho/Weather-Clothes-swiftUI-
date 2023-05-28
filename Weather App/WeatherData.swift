import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Codable {
    //let temp_min: Double
    let temp : Double
    let temp_max : Double
    let temp_min : Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
