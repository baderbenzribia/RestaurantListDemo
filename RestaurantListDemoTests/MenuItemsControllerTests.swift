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
    }
    
    override func tearDown() {
        super.tearDown()
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
