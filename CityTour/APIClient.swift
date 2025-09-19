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
    
    // Function to fetch nearby places
    func getPlaces(forKeyword keyword : String, latitude : Double, longitude : Double) async {
        guard let url = createURL(latitude: latitude, longitude: longitude, keyword: keyword) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return
            }
            
            let JSON = try JSONDecoder().decode(PlacesResponseModel.self, from: data)
            
        } catch{
            print(error.localizedDescription)
        }
    }
    
    // Function to create Url
    private func createURL(latitude : Double, longitude : Double, keyword : String) -> URL? {
        var urlComponents = URLComponents(string: baseURL)
        
        let queryItems: [URLQueryItem] = [
            
            URLQueryItem(name: "location", value: String(latitude) + "," + String(longitude)),
            
            URLQueryItem(name: "rankby", value: "distance"),
            
            URLQueryItem(name: "keyword", value: keyword),
            
            URLQueryItem(name: "key", value: APIKey)
        ]
        
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.url
    }
}
