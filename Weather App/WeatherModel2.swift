import Foundation
import SwiftUI

class WeatherModel2: ObservableObject {
    @Published var tempMax: String = "気温"
    @Published var tempMin: String = "気温"
    @Published var tempInt : Int = -31
    
    var tempString: String {
        switch tempInt {
        case 28...50:
            return "G1"
        case 23...27:
            return "G4"
        case 17...22:
            return "G7"
        case 10...16:
            return "G10"
        case 5...9:
            return "G13"
        case -30...4:
            return "G16"
        default:
            return "q"
        }
    }
    
    var tempString1: String {
        switch tempInt {
        case 28...50:
            return "G2"
        case 23...27:
            return "G5"
        case 17...22:
            return "G8"
        case 10...16:
            return "G11"
        case 5...9:
            return "G14"
        case -30...4:
            return "G17"
        default:
            return "q"
        }
    }
    
    var tempString2: String {
        switch tempInt {
        case 28...50:
            return "G3"
        case 23...27:
            return "G6"
        case 17...22:
            return "G9"
        case 10...16:
            return "G12"
        case 5...9:
            return "G15"
        case -30...4:
            return "G18"
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


