//
//  MenuItem.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 12.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// enum of the sorting value keys
enum SortingValueKey {
    case bestMatch
    case newest
    case ratingAverage
    case distance
    case popularity
    case averageProductPrice
    case deliveryCosts
    case minCost
}

// struct defining a element of the menu with the sorting value key
struct MenuItem {
    let title : String
    let key : SortingValueKey
    var isSelected : Bool
    
    init(key : SortingValueKey) {
        switch key {
        case .bestMatch:
            self.title = "Best Match"
            break
        case .newest:
            self.title = "Newest"
            break
        case .ratingAverage:
            self.title = "Rating Average"
            break
        case .distance:
            self.title = "Distance"
            break
        case .popularity:
            self.title = "Popularity"
            break
        case .averageProductPrice:
            self.title = "Average Product Price"
            break
        case .deliveryCosts:
            self.title = "Delivery Costs"
            break
        case .minCost:
            self.title = "Minimum Cost"
            break
        }
        self.key = key
        self.isSelected = false
    }
}
