//
//  MenuViewController.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 12.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import UIKit

// delegate to be notified when a sorting property is selected
protocol MenuItemDelegate : class {
    func didSelectMenuItem(menuItem: MenuItem)
}

class MenuViewController: UIViewController {

    @IBOutlet weak var tableView : UITableView!
    
    weak var delegate : MenuItemDelegate?
    
    var menuItemsController : MenuItemsController = MenuItemsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// tableView DataSource
extension MenuViewController : UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemsController.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuItem = menuItemsController.menuItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
        
        // update the cell with the menuItem
        cell.menuItem = menuItem
        
        return cell
    }
}

// tableView Delegate
extension MenuViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // set the menuItem selected to be visible to the user
        menuItemsController.setSelectedAt(index: indexPath.row)
        
        // reload the tableView
        self.tableView.reloadData()
        
        // notify the delegate that a menuItem is selected
        self.delegate?.didSelectMenuItem(menuItem: menuItemsController.menuItems[indexPath.row])
        
        // close the right side menu
        dismiss(animated: true, completion: nil)
    }
}
