//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 01/05/2024.
//

//The code defines a SwiftUI view that fetches weather and forecast data based on the device's current location using Core Location services.

import SwiftUI
import CoreLocationUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var forecast: [DailyForecast] = []
    
    var body: some View {
        VStack {
            if locationManager.location != nil {
                if let weather = weather {
                    WeatherView(weather: weather, forecast: forecast)
                } else {
                    LoadingView()
                        .onAppear {
                            fetchDataForCurrentLocation()
                        }
                }
            } else {
                if locationManager.isLoading {
                    ProgressView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
    }
    
// Function to fetch weather and forecast data
    func fetchDataForCurrentLocation() {
        Task {
            do {
                guard let location = locationManager.location else {
                    print("Location is not available.")
                    return
                }
                
                let weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                self.weather = weather
                
                let forecastResponse = try await weatherManager.getFiveDayForecast(latitude: location.latitude, longitude: location.longitude)
                self.forecast = groupForecastByDay(forecasts: forecastResponse)
            } catch {
                print("Error fetching data:", error)
            }
        }
    }
    
// Group forecast by day
    private func groupForecastByDay(forecasts: [ForecastResponse.Forecast]) -> [DailyForecast] {
        var dailyForecasts: [String: DailyForecast] = [:]
        let currentDate = Date()
        let calendar = Calendar.current
        
        for forecast in forecasts {
            let date = Date(timeIntervalSince1970: TimeInterval(forecast.dt))
            if calendar.isDate(date, inSameDayAs: currentDate) {
                continue
            }
            
            let dayString = dateFormattedForDay(date)
            
            if var dailyForecast = dailyForecasts[dayString] {
                if forecast.main.temp > dailyForecast.maxTemp {
                    dailyForecast.maxTemp = forecast.main.temp
                    dailyForecast.weather = forecast.weather.first
                }
                dailyForecasts[dayString] = dailyForecast
            } else {
                dailyForecasts[dayString] = DailyForecast(date: date, maxTemp: forecast.main.temp, weather: forecast.weather.first)
            }
        }
        
        return dailyForecasts.values.sorted { $0.date < $1.date }
    }
    
// Date formatting logic
    private func dateFormattedForDay(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    ContentView()
}

