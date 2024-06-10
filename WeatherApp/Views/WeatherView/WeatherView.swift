//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 23/05/2024.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    var forecast: [DailyForecast] = []
    
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
                    ForEach(forecast.prefix(5), id: \.date) { dayForecast in
                        WeatherDayView(date: dayForecast.date,
                                       imageName: getWeatherIcon(for: dayForecast.weather?.main ?? "Clear"),
                                       temperature: Int(dayForecast.maxTemp.rounded()))
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WeatherView(weather: ModelData.previewWeather, forecast: ModelData.previewForecast)
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
        return "sun.max.fill"
    }
}

