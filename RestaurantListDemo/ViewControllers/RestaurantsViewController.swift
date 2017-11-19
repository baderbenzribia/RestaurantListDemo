//
//  ViewController.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 10.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import UIKit
import SideMenu

class RestaurantsViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    // create a global restaurants controller
    var restaurantsController : RestaurantsContoller = RestaurantsContoller()
    
    // dataSource of the tableView
    var dataSource : [Restaurant] = []
    
    // create the search controller
    let searchController = UISearchController(searchResultsController: nil)
    
    // check if the search is active and if the text in the searchBar is not empty
    var isFiltering : Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Restaurants"
        
        // add a right button for selecting sorting property
        setRightBarButtonTitle(title: "Sort by")
        
        // init the dataSource with the sorted list of restaurants in the restaurantsController
        dataSource = restaurantsController.sort()
        
        // add the searchController
        self.addSearchController()
        
        // add the right side menu
        self.addRightMenuFilter()
        
        // register to keyboard notifications
        self.registerForKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // define the search controller and set the search bar in the header of the tableView
    func addSearchController()
    {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "Search restaurant"
        tableView.tableHeaderView = searchController.searchBar
    }
    
    // create the right side menu
    func addRightMenuFilter()
    {
        let menuVC = storyboard!.instantiateViewController(withIdentifier: "menuVC") as! MenuViewController
        menuVC.delegate = self
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: menuVC)
        
        SideMenuManager.default.menuRightNavigationController = menuRightNavigationController
    }
    
    // create the right bar button item
    func setRightBarButtonTitle(title : String) -> Void
    {
        let rightButton : UIBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    // action of the right bar button item
    @objc func rightBarButtonTapped()
    {
        present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
    }
    
    // register for the keyboard notifications
    fileprivate func registerForKeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    // make the tableview content size adapted the rest of the screen after showing the keyboard
    @objc func keyboardWillShow(notification: Notification)
    {
        guard let userInfo = notification.userInfo else {
            return
        }
        guard var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
    
    // reset the table view content size
    @objc func keyboardWillHide(notification: Notification)
    {
        var contentInset:UIEdgeInsets = tableView.contentInset
        contentInset.bottom = 0
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
}

// define the tableView DataSource
extension RestaurantsViewController : UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get the selected restaurant
        let restaurant = dataSource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantViewCell
        
        // update the cell with the selected restaurant
        cell.restaurant = restaurant
        
        // add the sorting property if it exist
        if let key = restaurantsController.selectedSortingValueKey {
            cell.updateUIWithSortingValue(key: key)
        }
        return cell
    }
}

// define the tableView Delegate
extension RestaurantsViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        // set the selected restaurant as favorite
        restaurantsController.setFavorite(restaurant: dataSource[indexPath.row])
        
        // check if the searchController is active
        if isFiltering
        {
            // update the dataSource with filtered list
            dataSource = restaurantsController.filterBy(string: searchController.searchBar.text!)
        }
        else {
            // else sort the list after the update
            dataSource = restaurantsController.sort()
        }
        
        // save the list with the new favorite/noFavorite item
        restaurantsController.saveRestaurants()
        
        // reload the tableView
        self.tableView.reloadData()
    }
}

// delegate notified after selecting a sorting property in the right side menu
extension RestaurantsViewController : MenuItemDelegate
{
    func didSelectMenuItem(menuItem: MenuItem)
    {
        // set the selected sorting property in the restaurantsController
        restaurantsController.selectedSortingValueKey = menuItem.key
        
        // make the new sort
        dataSource = restaurantsController.sort()
        
        // reload the tableView
        self.tableView.reloadData()
    }
}

// search controller delegate
extension RestaurantsViewController : UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        // check if the serachBar text is Empty
        if searchController.searchBar.text!.isEmpty {
            // sort the list without filtering
            dataSource = restaurantsController.sort()
        }
        else {
            // else filter the list with given string
            dataSource = restaurantsController.filterBy(string: searchController.searchBar.text!)
        }
        
        // reload the tableView and scroll to the top
        self.tableView.reloadData()
        
        if dataSource.count > 0
        {
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
        }
    }
}
