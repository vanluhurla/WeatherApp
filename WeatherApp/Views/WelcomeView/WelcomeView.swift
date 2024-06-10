//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 22/05/2024.
//

// The WelcomeView struct defines a user interface for welcoming users to the Weather App. It includes an animation, some introductory text, and a button for sharing the user's current location. 

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 50) {
                WelcomeAnimationView()
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
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    WelcomeView()
}
