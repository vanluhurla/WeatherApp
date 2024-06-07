//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 22/05/2024.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Spacer() // Spacer to push content down from top
            
            VStack(spacing: 50) {
                LoadingAnimationView()
                    .frame(height: 250)
                
                Text("Welcome to the Weather App")
                    .bold().font(.title)
                
                Text("Please, share your current location to get the weather in your area.")
                    .padding()
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
            .padding()
            
            Spacer() // Spacer to push content up from bottom
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white) // Optional: Add a background color if needed
    }
}

#Preview {
    WelcomeView()
}
