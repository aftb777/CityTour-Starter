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
    typealias PlacesResult = Result<PlacesResponseModel, PlacesError>
    
    private func responseType(statusCode : Int) -> ResponseType {
        // 200-299 - OK
        // 400-499 - bad request
        // 500-599 - server is wrong
        
        switch statusCode {
        case 200..<300:
            print("Success")
            return ResponseType.succes
        case 400..<500:
            print("Bad Request")
            return .badRequest
        case 500..<600:
            print("Server Error")
            return .serverError
        default:
            print("Unknown Error")
            return ResponseType.notFound
        }
    }
    
    // Function to fetch nearby places
    func getPlaces(forKeyword keyword : String, latitude : Double, longitude : Double) async -> PlacesResult {
        guard let url = createURL(latitude: latitude, longitude: longitude, keyword: keyword) else {
            return .failure(.InvalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // for status code to check URL status
            guard let response = response as? HTTPURLResponse else {
                return .failure(.InvalidResponse)
            }
            let responseType = responseType(statusCode: response.statusCode)
            
            switch responseType {
            case .badRequest, .notFound, .serverError:
                return .failure(.APIerror)
            case .succes:
                let decodedJSON = try JSONDecoder().decode(PlacesResponseModel.self, from: data)
                return .success(decodedJSON)
            }
            
//            guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                return
//            }
            
        } catch{
            print(error.localizedDescription)
            return .failure(.APIerror)
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
