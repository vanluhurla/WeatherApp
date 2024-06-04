//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var forecast: [ForecastResponse.Forecast] = []
    
    var body: some View {
        ZStack {
            BackgroundView(topColor: .blue, bottomColor: Color("lightBlue"))
            
            VStack {
                CityTextView(cityName: weather.name)
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                
                MainWeatherStatusView(imageName: getWeatherIcon(for: weather.weather.first?.main ?? "Clear"),
                                      temperature: weather.main.feelsLike.roundDouble() + "°")
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(forecast.prefix(5), id: \.dt) { dayForecast in
                        let date = Date(timeIntervalSince1970: TimeInterval(dayForecast.dt))
                        WeatherDayView(date: date,
                                       imageName: getWeatherIcon(for: dayForecast.weather.first?.main ?? "Clear"),
                                       temperature: Int(dayForecast.main.temp.rounded()))
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WeatherView(weather: previewWeather, forecast: previewForecast)
}

struct WeatherDayView: View {
    var date: Date
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(date, formatter: dateFormatter)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundStyle(.white)
            
            VStack {
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Text("\(temperature)°")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Use "EEE" for short weekday names (e.g., "Thu" for Thursday)
        return formatter
    }
}

struct BackgroundView: View {
    var topColor: Color
    var bottomColor: Color
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [topColor, bottomColor]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(edges: .all)
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundStyle(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temperature: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height:  180)
            
            Text("\(temperature)")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}

func getWeatherIcon(for weatherCondition: String) -> String {
    switch weatherCondition {
    case "Clear":
        return "sun.max.fill"
    case "Clouds":
        return "cloud.fill"
    case "Rain":
        return "cloud.rain.fill"
    case "Drizzle":
        return "cloud.drizzle.fill"
    case "Thunderstorm":
        return "cloud.bolt.fill"
    case "Snow":
        return "snow"
    default:
        return "cloud.fill"
    }
}


//WeatherDayView(dayOfWeek: "TUE",
//               imageName: "cloud.sun.fill",
//               temperature: 18)
//WeatherDayView(dayOfWeek: "TUE",
//               imageName: "cloud.sun.fill",
//               temperature: 18)
//WeatherDayView(dayOfWeek: "TUE",
//               imageName: "cloud.sun.fill",
//               temperature: 18)
//WeatherDayView(dayOfWeek: "TUE",
//               imageName: "cloud.sun.fill",
//               temperature: 18)
//WeatherDayView(dayOfWeek: "TUE",
//               imageName: "cloud.sun.fill",
//               temperature: 18)


//struct WeatherDayView: View {
//
//    var dayOfWeek: String
//    var imageName: String
//    var temperature: Int
//
//    var body: some View {
//        VStack {
//            Text(dayOfWeek)
//                .font(.system(size: 16, weight: .medium, design: .default))
//                .foregroundStyle(.white)
//
//            VStack() {
//                Image(systemName: imageName)
//                    .renderingMode(.original)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 40, height:  40)
//
//                Text("\(temperature)°")
//                    .font(.system(size: 28, weight: .medium))
//                    .foregroundColor(.white)
//            }
//        }
//    }
//}
