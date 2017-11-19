//
//  MenuViewCell.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 12.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import UIKit

class MenuViewCell: UITableViewCell {
    
    @IBOutlet weak var keyNameLabel : UILabel!

    // update the UI after menuItem is set
    var menuItem : MenuItem?
    {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI()
    {
        self.keyNameLabel.text = menuItem?.title
        if menuItem?.isSelected == true {
            self.accessoryType = .checkmark
        }
        else {
            self.accessoryType = .none
        }
    }
}
