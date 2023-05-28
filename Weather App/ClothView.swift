import SwiftUI

struct ClothView: View {
    @AppStorage("city") var city = "city"
    @StateObject var weatherModel1 = WeatherModel1()
    @StateObject var weatherModel = WeatherModel()
    var body: some View {
        VStack{
            Text(city)
                .padding()
            
            HStack{
                Image("\(weatherModel1.tempString)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                
                Image("\(weatherModel1.tempString1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                
                Image("\(weatherModel1.tempString2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
            }//HStack
            
            Spacer()
                .frame(height: 100)
            
            HStack{
                Text("最高気温：" + weatherModel1.tempMax + "°")
                    .padding()
                
                Text("最低気温：" + weatherModel1.tempMin + "°")
                    .padding()
            } //HStack
        } //VStack
        .onAppear(perform: {
            weatherModel1.fetchWeather(cityName: city)
        })
    }
}

struct ClothView_Previews: PreviewProvider {
    static var previews: some View {
        ClothView()
    }
}
