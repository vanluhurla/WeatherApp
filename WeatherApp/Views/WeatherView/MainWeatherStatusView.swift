//
//  MainWeatherStatusView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 10/06/2024.
//

import SwiftUI

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
