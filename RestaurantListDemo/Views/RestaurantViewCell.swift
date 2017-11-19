//
//  RestaurantViewCell.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 10.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import UIKit

class RestaurantViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var statusLabel : UILabel!
    @IBOutlet weak var selectedSortingValueLabel : UILabel!
    
    // update the UI after restaurant is set
    var restaurant : Restaurant?
    {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        self.nameLabel.text = restaurant?.name
        self.statusLabel.text = restaurant?.restaurantStatus
        
        if restaurant?.isFavorite == true {
            self.accessoryType = .checkmark
        }
        else {
            self.accessoryType = .none
        }
    }
    
    // add a label of the sorting property
    func updateUIWithSortingValue(key : SortingValueKey)
    {
        self.selectedSortingValueLabel.text = restaurant?.sortingValueString(sortingKey: key)
    }
    
}
