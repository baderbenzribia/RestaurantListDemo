//
//  RestaurantsTests.swift
//  RestaurantListDemoTests
//
//  Created by Bader BEN ZRIBIA on 18.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import XCTest

@testable import RestaurantListDemo

class RestaurantsTests: XCTestCase {
    
    let restaurantsController = RestaurantsContoller()
    
    
    override func setUp() {
        super.setUp()
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetFavoriteAtIndex()
    {
        let restaurant = restaurantsController.restaurants[4]
        restaurantsController.setFavoriteAt(index: 4)
        let restaurantFav = restaurantsController.restaurants[4]
        XCTAssertNotEqual(restaurant.isFavorite, restaurantFav.isFavorite)
    }
    
    func testSetRestaurantAsFavorite()
    {
        let restaurant = restaurantsController.restaurants[6]
        restaurantsController.setFavorite(restaurant: restaurant)
        let restaurantFav = restaurantsController.restaurants[6]
        XCTAssertNotEqual(restaurant.isFavorite, restaurantFav.isFavorite)
    }
    
    func testSort()
    {
        let sortedRestaurants = restaurantsController.sort()
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite
            {
                XCTAssertGreaterThanOrEqual(sortedRestaurants[i].status, sortedRestaurants[i+1].status)
            }
        }
        
    }
    
    func testSortByBestMatch()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .bestMatch)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertGreaterThanOrEqual(sortedRestaurants[i].sortingValues.bestMatch, sortedRestaurants[i+1].sortingValues.bestMatch)
            }
        }
        
    }
    
    func testSortByNewest()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .newest)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertGreaterThanOrEqual(sortedRestaurants[i].sortingValues.newest, sortedRestaurants[i+1].sortingValues.newest)
            }
        }
    }
    
    func testSortByRatingAverage()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .ratingAverage)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertGreaterThanOrEqual(sortedRestaurants[i].sortingValues.ratingAverage, sortedRestaurants[i+1].sortingValues.ratingAverage)
            }
        }
    }
    
    func testSortByDistance()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .distance)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertLessThanOrEqual(sortedRestaurants[i].sortingValues.distance, sortedRestaurants[i+1].sortingValues.distance)
            }
        }
    }
    
    func testSortByPopularity()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .popularity)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertGreaterThanOrEqual(sortedRestaurants[i].sortingValues.popularity, sortedRestaurants[i+1].sortingValues.popularity)
            }
        }
    }
    
    func testSortByAverageProductPrice()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .averageProductPrice)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertLessThanOrEqual(sortedRestaurants[i].sortingValues.averageProductPrice, sortedRestaurants[i+1].sortingValues.averageProductPrice)
            }
        }
    }
    
    func testSortByDeliveryCosts()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .deliveryCosts)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertLessThanOrEqual(sortedRestaurants[i].sortingValues.deliveryCosts, sortedRestaurants[i+1].sortingValues.deliveryCosts)
            }
        }
    }
    
    func testSortByMinCost()
    {
        let sortedRestaurants = restaurantsController.sortBy(key: .minCost)
        for i in 0..<(sortedRestaurants.count-1) {
            if sortedRestaurants[i].isFavorite == sortedRestaurants[i+1].isFavorite &&
                sortedRestaurants[i].status == sortedRestaurants[i+1].status
            {
                XCTAssertLessThanOrEqual(sortedRestaurants[i].sortingValues.minCost, sortedRestaurants[i+1].sortingValues.minCost)
            }
        }
    }
    
    func testFilterByString()
    {
        let filterString = "Re"
        let filteredRestaurants = restaurantsController.filterBy(string: filterString)
        
        for restaurant in filteredRestaurants {
            
            let restaurantName = restaurant.name.lowercased()
            XCTAssertTrue(restaurantName.contains(filterString.lowercased()))
            
        }
    }
}
