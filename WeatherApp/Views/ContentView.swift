//
//  ContentView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 01/05/2024.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

class Debouncer {
    private let delay: TimeInterval
    private var timer: Timer?
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func run(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State var forecast: [ForecastResponse.Forecast] = []
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather, forecast: forecast)
                } else {
                    LoadingView()
                        .onAppear {
                            // Fetch weather and forecast data when view appears
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
                let groupedForecast = weatherManager.groupForecastByDay(forecasts: forecastResponse.list)
                self.forecast = groupedForecast
            } catch {
                print("Error fetching data:", error)
            }
        }
    }
}



//struct ContentView: View {
//    @StateObject var locationManager = LocationManager()
//    var weatherManager = WeatherManager()
//    @State var weather: ResponseBody?
//    @State var forecast: [ForecastResponse.Forecast] = []
//    
//    var body: some View {
//        VStack {
//            if let location = locationManager.location {
//                if let weather = weather {
//                    WeatherView(weather: weather, forecast: forecast)
//                } else {
//                    LoadingView()
//                        .task {
//                            do {
//                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, 
//                                                                                     longitude: location.longitude)
//                                let forecastResponse = try await weatherManager.getFiveDayForecast(latitude: location.latitude, 
//                                                                                                   longitude: location.longitude)
//                                forecast = forecastResponse.list
//                            } catch {
//                                print("Error getting weather: \(error)")
//                            }
//                        }
//                }
//            } else {
//                if locationManager.isLoading  {
//                    ProgressView()
//                } else {
//                    WelcomeView()
//                        .environmentObject(locationManager)
//                }
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}

