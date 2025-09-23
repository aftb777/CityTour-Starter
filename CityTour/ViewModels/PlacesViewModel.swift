//
//  PlacesViewModel.swift
//  CityTour
//
//  Created by Aftaab Mulla on 20/09/25.
//

import Foundation
import CoreLocation

// PlacesViewModel -> ye ViewModel hai jo CoreLocation se user ki location handle karega.
// @MainActor -> ensure karta hai ki UI related updates main thread pe hi chalein.
@MainActor
class PlacesViewModel : NSObject, ObservableObject {
    
    // APIClient instance banaya -> ye API calls ke liye use hoga (Google Places etc.)
    private let ApiClient = APIClient()
    
    // User ka current location yaha store hoga
    var CurrentLocation : CLLocation?
    
    // CoreLocation ka manager -> isse hi location aur permissions handle karte hain
    private let locationManager = CLLocationManager()
    
    // Init -> jab ViewModel create hota hai tab run hota hai
    override init() {
        super.init()
        
        // Location manager ka delegate set karte hain taaki callbacks aayen (permission, updates)
        locationManager.delegate = self
        
        // User se permission maangna (only when app in use)
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchPlaces(location : CLLocation) async {
        await ApiClient.getPlaces(forKeyword: "Coffee", latitude: CLLocation.init().coordinate.latitude, longitude: CLLocation.init().coordinate.latitude)
    }
}

extension PlacesViewModel: @MainActor CLLocationManagerDelegate {
    
    // Ye delegate method tab call hota hai jab user authorization (permission) change karta hai
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways :
            // Agar permission mil gaya hai -> ek baar location request karo
            locationManager.requestLocation()
            
        default:
            // Agar deny ya not determined hai -> abhi kuch nahi karna
            break
        }
    }
    
    // Ye delegate method tab call hota hai jab nayi location update milti hai
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Array of locations aata hai -> pehla location (most recent) le lo
        guard let location = locations.first else {
            return
        }
        
        // CurrentLocation property me save kar lo (baad me View use karega)
        CurrentLocation = location
        
        Task {
            await fetchPlaces(location: location)
        }
    }
}
