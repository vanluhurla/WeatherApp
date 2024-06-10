//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Vanessa Hurla on 20/05/2024.
//

// THis class manages location requests and updates the observable properties location and isLoading accordingly. When a location request is made, it sets isLoading to true. Upon receiving a location update or encountering an error, it updates the location and isLoading properties and notifies any observers of these changes.

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
