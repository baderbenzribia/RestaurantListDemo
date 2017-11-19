//
//  SortingValues.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 10.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// struct defining the Sorting Values model
struct SortingValues : Codable {
    let bestMatch : Double
    let newest : Double
    let ratingAverage : Double
    let distance : Int
    let popularity : Double
    let averageProductPrice : Int
    let deliveryCosts : Int
    let minCost : Int
    
    // keys of the json
    private enum CodingKeys: String, CodingKey {
        case bestMatch
        case newest
        case ratingAverage
        case distance
        case popularity
        case averageProductPrice
        case deliveryCosts
        case minCost
    }
}
