//
//  PersistanceManagerTests.swift
//  RestaurantListDemoTests
//
//  Created by Bader BEN ZRIBIA on 18.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import XCTest

@testable import RestaurantListDemo

class PersistanceManagerTests: XCTestCase {
    
    let serialQueue: DispatchQueue = DispatchQueue(label: "PersistanceQueue")
    let persistanceManager = PersistanceManager()
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    
    func testGetRestaurantsFromSampleFile()
    {
        let restaurants = persistanceManager.getRestaurantsFromSampleFile()
        XCTAssertEqual(restaurants.count, 19)
        XCTAssertEqual(restaurants[0].name, "Tanoshii Sushi")
        XCTAssertEqual(restaurants[0].status, .open)
        XCTAssertEqual(restaurants[0].isFavorite, false)
        XCTAssertEqual(restaurants[0].sortingValues.distance, 1190)
    }
    
    func testSaveAndGetRestaurantsFromDisk()
    {
        var restaurants = persistanceManager.getRestaurantsFromSampleFile()
        restaurants[0].isFavorite = true
        persistanceManager.saveRestaurantsToDisk(restaurants: restaurants)
        let savedRestaurants = persistanceManager.getRestaurantsFromDisk()
        
        XCTAssertEqual(savedRestaurants.count, restaurants.count, "Number of elements of the array is not the same after saving")
        
        for i in 0..<restaurants.count
        {
            XCTAssertEqual(savedRestaurants[i].name, restaurants[i].name, "RestaurantName is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].status, restaurants[i].status, "RestaurantStatus is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].isFavorite, restaurants[i].isFavorite, "RestaurantIsFavorite is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.bestMatch,restaurants[i].sortingValues.bestMatch, "RestaurantBestMatch is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.newest,restaurants[i].sortingValues.newest, "RestaurantNewest is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.ratingAverage,restaurants[i].sortingValues.ratingAverage, "RestaurantRatingAverage is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.distance,restaurants[i].sortingValues.distance, "RestaurantDistance is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.popularity,restaurants[i].sortingValues.popularity, "RestaurantPopularity is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.averageProductPrice,restaurants[i].sortingValues.averageProductPrice, "RestaurantAverageProductPrice is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.deliveryCosts,restaurants[i].sortingValues.deliveryCosts, "RestaurantDeliveryCost is not the same after saving")
            XCTAssertEqual(savedRestaurants[i].sortingValues.minCost,restaurants[i].sortingValues.minCost, "RestaurantMinCost is not the same after saving")
        }
    
    }
}
