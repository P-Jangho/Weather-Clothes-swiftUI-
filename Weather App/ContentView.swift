//
//  ContentView.swift
//  Weather App
//
//  Created by PJH on 2022/08/09.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("city") var city : String = "city"
    @State private var selection1 = 0
    @StateObject var weatherModel = WeatherModel()
    @StateObject var weatherModel1 = WeatherModel1()
    @State var cityName: String = ""
    @State private var isNight = false
    var currentTime = Date()
    
//    static let dateFormat: DateFormatter = {
//           let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm"
//            return formatter
//        }()
    
    var body: some View {
        NavigationView {
            ZStack{
                
                LinearGradient(gradient: Gradient(colors:[isNight ? Color.black : Color.blue, isNight ? Color.gray : Color.white]), startPoint: .topTrailing, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                
                
                
                VStack{
                    
//                    Text("\(currentTime, formatter: ContentView.dateFormat)")
                    
//                    Text(currentTime, style: .time)
//                        .padding()
                    
                    Text(weatherModel.title)
                        .padding()
                    
                    Image(systemName: "\(weatherModel.conditionString)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120, alignment: .center)
                        .foregroundColor(weatherModel.conditionColor)
                        .cornerRadius(30)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    HStack{
                        Text(weatherModel.conditionDescription)
                            .padding()
                        
                        Text(weatherModel.temp + "°")
                            .padding()
                    } //HStack-1
                    
                    Spacer()
                        .frame(height: 100)
                    
                    HStack {
                        TextField("都市入力", text: $cityName)
                        Button(action: {
                            weatherModel.fetchWeather(cityName: cityName)
                            
                            city = cityName
                            
//                            if (cityName.contains(" ")) {
//                                cityName = cityName.replacingOccurrences(of: " ", with: "%20")
//
//                            }
                            cityName = ""
                        }, label: {
                            Text("入力")
                        })
                    } //HStack-2
                    .padding()
                    
                    Group{
                        Picker("性別", selection: $selection1){
                            //바인딩
                            Text("男")
                                .tag(1)
                            Text("女")
                                .tag(2)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(minWidth: 0, maxWidth: 100)
                        .compositingGroup()
                        .clipped()
                        
                        Spacer()
                            .frame(height: 60)
                        
                        if (selection1 == 1){
                            NavigationLink(
                                destination: ClothView()
                            )
                            {Text("検索")}
                        }else if(selection1 == 2){
                            NavigationLink(
                                destination: ClothViewG()
                            )
                            {Text("検索")}
                        }else {
                            Button(action:{
                            }){
                                Text("検索")
                            }
                        }
                        Spacer()
                            .frame(height: 60)
                        
                        Button(action:{
                            weatherModel.fetchWeather(cityName: city)
                        }){
                            Text(city)
                        }
                    } //Group
                } //VStack
            } //ZStack
        } //navi
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
    
}
