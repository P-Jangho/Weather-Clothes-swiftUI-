import Foundation
import SwiftUI

class WeatherModel1: ObservableObject {
    @Published var tempMax: String = "気温"
    @Published var tempMin: String = "気温"
    @Published var tempInt : Int = -31
    
    var tempString: String {
        switch tempInt {
        case 28...50:
            return "M1"
        case 23...27:
            return "M4"
        case 17...22:
            return "M7"
        case 10...16:
            return "M10"
        case 5...9:
            return "M13"
        case -30...4:
            return "M16"
        default:
            return "q"
        }
    }
    
    var tempString1: String {
        switch tempInt {
        case 28...50:
            return "M2"
        case 23...27:
            return "M5"
        case 17...22:
            return "M8"
        case 10...16:
            return "M11"
        case 5...9:
            return "M14"
        case -30...4:
            return "M17"
        default:
            return "q"
        }
    }
    
    var tempString2: String {
        switch tempInt {
        case 28...50:
            return "M3"
        case 23...27:
            return "M6"
        case 17...22:
            return "M9"
        case 10...16:
            return "M12"
        case 5...9:
            return "M15"
        case -30...4:
            return "M18"
        default:
            return "q"
        }
    }
    
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
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                // 데이터가 없을때
                print("??")
                return
            }
            
            do {
                let model = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async {
                    self.tempMax = "\(model.main.temp_max)"
                    self.tempMin = "\(model.main.temp_min)"
                    self.tempInt = Int(model.main.temp)
                }
            } catch {
                print("Failed")
            }
        }
        task.resume()
    }
}

