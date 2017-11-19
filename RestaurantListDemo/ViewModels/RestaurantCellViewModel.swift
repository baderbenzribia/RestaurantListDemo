//
//  RestaurantViewModel.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 14.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// a viewModel of the restaurant to get information that will be show in the cell
protocol RestaurantCellViewModel {
    var restaurantStatus : String { get }
    func sortingValueString(sortingKey : SortingValueKey) -> String
    
}


extension Restaurant : RestaurantCellViewModel {
    
    // string of the restaurant state
    var restaurantStatus : String {
        switch status
        {
        case .open:
            return "Open"
            
        case .orderAhead:
            return "Order Ahead"
            
        case .closed:
            return "Closed"
            
        }
    }
    
    // string with the sorting property
    func sortingValueString(sortingKey : SortingValueKey) -> String {
        switch sortingKey
        {
        case .bestMatch:
            return "Best Match : \(sortingValues.bestMatch)"
        
        case .newest:
            return "Newest : \(sortingValues.newest)"
            
        case .ratingAverage:
            return "Rating Average : \(sortingValues.ratingAverage)"
            
        case .distance:
            return String(format: "Distance : %.3f km", Double(sortingValues.distance) / 1000.0)
            
        case .popularity:
            return "Popularity : \(sortingValues.popularity)"
            
        case .averageProductPrice:
            return "Average Product Price : \(sortingValues.averageProductPrice)€"
            
        case .deliveryCosts:
            return "Delivery Costs : \(sortingValues.deliveryCosts)€"
            
        case .minCost:
            return "Minimum Cost : \(sortingValues.minCost)€"

        }
    }
    
}
