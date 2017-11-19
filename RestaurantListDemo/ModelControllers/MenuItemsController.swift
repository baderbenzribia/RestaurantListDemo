//
//  MenuItemsController.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 12.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// class managing the list of sorting properties
class MenuItemsController
{
    var menuItems : [MenuItem] = []
    
    // init with the desired sorting properties
    init()
    {
        menuItems = [MenuItem(key: .bestMatch),
                     MenuItem(key: .newest),
                     MenuItem(key: .ratingAverage),
                     MenuItem(key: .distance),
                     MenuItem(key: .popularity),
                     MenuItem(key: .averageProductPrice),
                     MenuItem(key: .deliveryCosts),
                     MenuItem(key: .minCost)]
    }
    
    // select one item from the list of sorting properties
    func setSelectedAt(index : Int) {
        for i in 0..<menuItems.count
        {
            if index == i {
                menuItems[i].isSelected = true
            }
            else {
                menuItems[i].isSelected = false
            }
        }
    }
}
