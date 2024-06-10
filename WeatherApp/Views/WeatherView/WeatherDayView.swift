//
//  WeatherDayView.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 10/06/2024.
//

import SwiftUI

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
        formatter.dateFormat = "EEE"
        return formatter
    }
}
