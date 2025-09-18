//
//  APIClient.swift
//  CityTour
//
//  Created by Aftaab Mulla on 18/09/25.
//

import Foundation
import CoreLocation

class APIClient {
    private let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    private let APIKey = "YOUR_API_KEY_HERE"
    
    private func createURL(latitude : Double, longitude : Double, keyword : String) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        
        var queryItems: [URLQueryItem] = [
            
            URLQueryItem(name: "location", value: String(latitude) + "," + String(longitude)),
            
            URLQueryItem(name: "rankby", value: "distance"),
            
            URLQueryItem(name: "keyword", value: keyword),
            
            URLQueryItem(name: "key", value: APIKey)
        ]
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
}
