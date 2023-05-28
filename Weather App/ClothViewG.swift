import SwiftUI

struct ClothViewG: View {
    @AppStorage("city") var city = "city"
    @StateObject var weatherModel2 = WeatherModel2()
    @StateObject var weatherModel = WeatherModel()
    var body: some View {
        VStack{
            Text(city)
                .padding()
            
            HStack{
                Image("\(weatherModel2.tempString)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                
                Image("\(weatherModel2.tempString1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
                
                Image("\(weatherModel2.tempString2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120, alignment: .center)
                    .cornerRadius(30)
            }//HStack

            Spacer()
                .frame(height: 100)
            
            HStack{
                Text("最高気温：" + weatherModel2.tempMax + "°")
                    .padding()
                
                Text("最低気温：" + weatherModel2.tempMin + "°")
                    .padding()
            } //HStack
        } //VStack
        .onAppear(perform: {
            weatherModel2.fetchWeather(cityName: city)
        })
    }
}

struct ClothViewG_Previews: PreviewProvider {
    static var previews: some View {
        ClothViewG()
    }
}
