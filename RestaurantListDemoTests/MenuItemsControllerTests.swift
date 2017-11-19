//
//  MenuItemsControllerTests.swift
//  RestaurantListDemoTests
//
//  Created by Bader BEN ZRIBIA on 18.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import XCTest

@testable import RestaurantListDemo

class MenuItemsControllerTests: XCTestCase {
    
    let menuItemsController = MenuItemsController()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSetSelected()
    {
        menuItemsController.setSelectedAt(index: 0)
        XCTAssertEqual(menuItemsController.menuItems[0].isSelected, true)
        
        menuItemsController.setSelectedAt(index: 1)
        XCTAssertEqual(menuItemsController.menuItems[0].isSelected, false)
        XCTAssertEqual(menuItemsController.menuItems[1].isSelected, true)
    }
    
}
