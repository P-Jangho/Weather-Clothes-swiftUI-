import Foundation
import SwiftUI

class WeatherModel: ObservableObject {
    
    @Published var title: String = "都市名"
    // 現在の都市
    @Published var descriptionText: String = "天気"
    // 現在の天気
    @Published var temp: String = "気温"
//    @Published var tempInt : Int = 0
    // 現在の気温
    @Published var conditionId: Int = 0
    // 현재 컨디션 아이디
    
    var conditionDescription: String {
        switch descriptionText {
        case "broken clouds":
            return "千切れ雲"
        case "few clouds":
            return "雲"
        case "clear sky":
            return "ハレ"
        case "mist":
            return "霧"
        case "moderate rain":
            return "適度な雨"
        case "heavy intensity rain":
            return "ひどい雨"
        case "light intensity shower rain":
            return "雨"
        case "light rain":
            return "雨"
        case "scattered clouds":
            return "乱れ雲"
        case "overcast clouds":
            return "雲"
        default:
            return "天気"
        }
    }
    
    var conditionColor: Color {
        switch conditionId {
//        case 200...232:
//            return Color.yellow
//        case 300...321:
//            return Color.yellow
//        case 500...531:
//            return Color.yellow
//        case 600...622:
//            return Color.yellow
//        case 701...711:
//            return Color.red
//        case 721:
//            return Color.red
//        case 731:
//            return Color.red
//        case 741...751:
//            return Color.red
//        case 761:
//            return Color.red
//        case 762:
//            return Color.red
//        case 771...781:
//            return Color.red
//        case 800:
//            return Color.white
        default:
            return Color.white
        }
    }
    
    var conditionString: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...711:
            return "smoke.fill"
        case 721:
            return "sun.haze.fill"
        case 731:
            return "sun.dust.fill"
        case 741...751:
            return "cloud.fog.fill"
        case 761:
            return "sun.dust.fill"
        case 762:
            return "cloud.fog.fill"
        case 771...781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...805:
            return "cloud.fill"
        default:
            return "icloud.slash.fill"
        }
    }
    
//    var tempString: String {
//        switch tempInt {
//        case 28...50:
//            return "sun.min"
//        case 23...27:
//            return "sun.min.fill"
//        case 20...22:
//            return "sun.max"
//        case 17...19:
//            return "sun.max.fill"
//        case 12...16:
//            return "sun.max.circle"
//        case 9...11:
//            return "sun.max.circle.fill"
//        case 5...9:
//            return "sunrise"
//        default:
//            return "sunrise.fill"
//        }
//    }
    
    init() {
        fetchWeather(cityName: "")
    }
    
    let myApiKey: String = Bundle.main.WEATHER_API_KEY
    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather?"
    
    func fetchWeather(cityName: String) {
        
        var editString: String = cityName
        if cityName.contains(" ") {
            
            editString = cityName.replacingOccurrences(of: " ", with: "%20");
            
        } //띄어쓰기가 있을 때의 작업
        
            let urlString = "\(weatherURL)&appid=\(myApiKey)&q=\(editString)&units=metric"
            print(urlString)
    
        guard let url = URL(string: urlString) else {
            // url 이 없을때
            print("url 이 없습니다.")
            return
        }
        
//        if URL(string: urlString) != nil {
//
//        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                // 데이터가 없을때
                print("??")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.title = model.name
                    self.descriptionText = model.weather[0].description
//                    self.temp = "\(model.main.temp_min)"
//                    self.temp = model.main.temp
                    self.temp = "\(model.main.temp)"
//                    self.tempInt = model.main.tempInt
                    self.conditionId = model.weather[0].id
                    
                }
            } catch {
                print("Failed")
            }
        }
        task.resume()
    }
 
}
