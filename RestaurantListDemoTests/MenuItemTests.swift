//
//  MenuItemTests.swift
//  RestaurantListDemoTests
//
//  Created by Bader BEN ZRIBIA on 18.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import XCTest

@testable import RestaurantListDemo

class MenuItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitMenuItem()  {
        let distanceMenuItem = MenuItem(key: .distance)
        XCTAssertEqual(distanceMenuItem.title, "Distance")
        
        let averageProductPriceMenuItem = MenuItem(key: .averageProductPrice)
        XCTAssertEqual(averageProductPriceMenuItem.title, "Average Product Price")
        
        let bestMatchMenuItem = MenuItem(key: .bestMatch)
        XCTAssertEqual(bestMatchMenuItem.title, "Best Match")
        
        let deliveryCostsMenuItem = MenuItem(key: .deliveryCosts)
        XCTAssertEqual(deliveryCostsMenuItem.title, "Delivery Costs")
        
        let newestMenuItem = MenuItem(key: .newest)
        XCTAssertEqual(newestMenuItem.title, "Newest")
        
        let popularityMenuItem = MenuItem(key: .popularity)
        XCTAssertEqual(popularityMenuItem.title, "Popularity")
        
        let ratingAverageMenuItem = MenuItem(key: .ratingAverage)
        XCTAssertEqual(ratingAverageMenuItem.title, "Rating Average")
        
        let minCostMenuItem = MenuItem(key: .minCost)
        XCTAssertEqual(minCostMenuItem.title, "Minimum Cost")
    }
    
}
