//
//  PlacesResponseModel.swift
//  CityTour
//
//  Created by Aftaab Mulla on 19/09/25.
//

import Foundation

// Decoding our JSON files, this is the data that all we need from API

struct PlacesResponseModel : Decodable {
    
    let results : [PlacesDetailResponseModel]
    
}

struct PlacesDetailResponseModel : Decodable, Identifiable {
    
    var id: String {
        return placeId
    }
    let placeId : String
    let name : String
    let photos : [PhotoInfo]? // Optional
    let rating : Double?
    let vicinity : String // instead of address vicinity is used in JSON
    
    // API has name place_id but we will use placeId in our code it makes our Swift code more readable
    enum codingKeys : String, CodingKey {
        case placeId = "place_id"
        case name
        case photos
        case rating
        case vicinity
        
    }
}

struct PhotoInfo : Decodable {
    let photoReference : String
    
    enum codingKeys : String, CodingKey {
        case photoReference = "photo_reference"
    }
}
