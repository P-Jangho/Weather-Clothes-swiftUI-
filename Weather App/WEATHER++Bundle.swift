//
//  WEATHER++Bundle.swift
//  Weather App
//
//  Created by cmStudent on 2023/05/28.
//

import Foundation

extension Bundle {
    
    // 생성한 .plist 파일 경로 불러오기
    var WEATHER_API_KEY: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else { return "" }
        
        // .plist를 딕셔너리로 받아오기
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["WEATHER_API_KEY"] as? String else {
            fatalError("WEATHER_API_KEY error")
        }
        return key
    }
}
