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

struct PlacesDetailResponseModel : Decodable {
    let place_id : String
    let name : String
    let photoUrl : [PhotoInfo]? // Optional
    let rating : Double?
    let address : String
    let vicinity : String // instead of address vicinity is used in JSON
}

struct PhotoInfo : Decodable {
    let photo_Reference : String
}
