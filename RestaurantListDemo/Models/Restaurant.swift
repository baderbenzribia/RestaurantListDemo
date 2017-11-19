//
//  Restaurant.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 10.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// struct defining the root of the sample json file
struct RestaurantList : Codable {
    let restaurants : [Restaurant]
}

// struct defining the restaurant model
struct Restaurant : Codable {
    let name : String
    let status : RestaurantStatus
    let sortingValues : SortingValues
    var isFavorite : Bool
    
    // keys of the json
    private enum CodingKeys: String, CodingKey {
        case name
        case status
        case sortingValues
        case isFavorite
    }
    
    // rewrite the init with coder so the isFavorite property get a false default value
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(RestaurantStatus.self, forKey: .status)
        sortingValues = try container.decode(SortingValues.self, forKey: .sortingValues)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}

// make Restaurant conform to Equatable to define name as the main equality property
extension Restaurant : Equatable
{
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name == rhs.name
    }
}

// enum of the opening states
enum RestaurantStatus : String, Codable {
    case open = "open"
    case closed = "closed"
    case orderAhead = "order ahead"
}

// make RestaurantStatus conform to Comparable to define the priority when it will be sorted by RestaurantStatus
extension RestaurantStatus : Comparable {
    static func <(lhs: RestaurantStatus, rhs: RestaurantStatus) -> Bool {
        if rhs == .open && lhs != .open {
            return true
        }
        else if rhs == .orderAhead && lhs == .closed {
            return true
        }
        else
        {
            return false
        }
    }
}

// make Bool conform to Comparable to define the priority when it will be sorted by isFavorite
extension Bool : Comparable
{
    public static func <(lhs: Bool, rhs: Bool) -> Bool {
        if rhs {
            return true
        }
        else {
            return false
        }
    }
}
