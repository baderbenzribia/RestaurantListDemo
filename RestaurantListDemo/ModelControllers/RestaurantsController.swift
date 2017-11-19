//
//  RestaurantsController.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 11.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

// class managing the list of restaurants
class RestaurantsContoller
{
    // create a global persistance manager
    let persistanceManager = PersistanceManager()
    
    // create a global list of restaurants
    var restaurants : [Restaurant] = []
    
    // define the key of sorting (optional)
    var selectedSortingValueKey : SortingValueKey?
    
    // init the list of restaurants with the list of restaurants in the sample file if it is the first launch
    // otherwise with the already saved restaurants.json file
    init()
    {
        if persistanceManager.isNotFirstLaunch {
            restaurants = persistanceManager.getRestaurantsFromDisk()
        }
        else {
            restaurants = persistanceManager.getRestaurantsFromSampleFile()
        }
    }
    
    // save the list of restaurants and make sure that isNotFirstLaunch is set true to use this list in the next launch of the app
    func saveRestaurants()
    {
        persistanceManager.saveRestaurantsToDisk(restaurants: restaurants)
        persistanceManager.isNotFirstLaunch = true
    }
    
    // set a restaurant at an index as favorite
    func setFavoriteAt(index : Int) {
        restaurants[index].isFavorite = !restaurants[index].isFavorite
    }
    
    // set a restaurant as favorite
    func setFavorite(restaurant : Restaurant)
    {
        // get restaurant index in the list
        if let index = restaurants.index(of: restaurant)
        {
            // set it as favorite
            setFavoriteAt(index: index)
        }
    }
    
    // sort the list of restaurants by the global sorting property if it is set
    // otherwise by the restaurant state and if it is favorite
    func sort() -> [Restaurant]
    {
        if let key = selectedSortingValueKey
        {
            return sortBy(key: key)
        }
        else
        {
            return restaurants.sorted(by: {
                ($0.isFavorite, $0.status) >
                    ($1.isFavorite, $1.status)
            })
        }
        
    }
    
    // sort the list by the given key
    func sortBy(key: SortingValueKey) -> [Restaurant]
    {
        switch key {
        case .distance:
            return sortByDistance()
            
        case .bestMatch:
            return sortByBestMatch()
            
        case .newest:
            return sortByNewest()
            
        case .ratingAverage:
            return sortByRatingAverage()
            
        case .popularity:
            return sortByPopularity()
            
        case .averageProductPrice:
            return sortByAverageProductPrice()
            
        case .deliveryCosts:
            return sortByDeliveryCosts()
            
        case .minCost:
            return sortByMinCost()
        }
    }
    
    // sort the list by bestMatch (from the highest to the lowest)
    func sortByBestMatch() -> [Restaurant]
    {
        return restaurants.sorted(by: {
            ($0.isFavorite, $0.status, $0.sortingValues.bestMatch) >
                ($1.isFavorite, $1.status, $1.sortingValues.bestMatch)
        })
    }
    
    // sort the list by newest (from the highest to the lowest)
    func sortByNewest() -> [Restaurant]
    {
        return restaurants.sorted(by: {
            ($0.isFavorite, $0.status, $0.sortingValues.newest) >
                ($1.isFavorite, $1.status, $1.sortingValues.newest)
        })
    }
    
    // sort the list by ratingAverage (from the highest to the lowest)
    func sortByRatingAverage() -> [Restaurant]
    {
        return restaurants.sorted(by: {
            ($0.isFavorite, $0.status, $0.sortingValues.ratingAverage) >
                ($1.isFavorite, $1.status, $1.sortingValues.ratingAverage)
        })
    }
    
    // sort the list by distance (from the lowest to the highest)
    func sortByDistance() -> [Restaurant]
    {
        return restaurants.sorted
            {
                if ($0.isFavorite == $1.isFavorite && $0.status == $1.status)
                {
                    return ($0.sortingValues.distance < $1.sortingValues.distance)
                }
                else
                {
                    return ($0.isFavorite, $0.status) > ($1.isFavorite, $1.status)
                }
        }
        
    }
    
    // sort the list by popularity (from the highest to the lowest)
    func sortByPopularity() -> [Restaurant]
    {
        return restaurants.sorted(by: {
            ($0.isFavorite, $0.status, $0.sortingValues.popularity) >
                ($1.isFavorite, $1.status, $1.sortingValues.popularity)
        })
    }
    
    // sort the list by averageProductPrice (from the lowest to the highest)
    func sortByAverageProductPrice() -> [Restaurant]
    {
        return restaurants.sorted{
            if ($0.isFavorite == $1.isFavorite && $0.status == $1.status)
            {
                return ($0.sortingValues.averageProductPrice < $1.sortingValues.averageProductPrice)
            }
            else
            {
                return ($0.isFavorite, $0.status) > ($1.isFavorite, $1.status)
            }
        }
    }
    
    // sort the list by deliveryCost (from the lowest to the highest)
    func sortByDeliveryCosts() -> [Restaurant]
    {
        return restaurants.sorted{
            if ($0.isFavorite == $1.isFavorite && $0.status == $1.status)
            {
                return ($0.sortingValues.deliveryCosts < $1.sortingValues.deliveryCosts)
            }
            else
            {
                return ($0.isFavorite, $0.status) > ($1.isFavorite, $1.status)
            }
        }
    }
    
    // sort the list by minCost (from the lowest to the highest)
    func sortByMinCost() -> [Restaurant]
    {
        return restaurants.sorted{
            if ($0.isFavorite == $1.isFavorite && $0.status == $1.status)
            {
                return ($0.sortingValues.minCost < $1.sortingValues.minCost)
            }
            else
            {
                return ($0.isFavorite, $0.status) > ($1.isFavorite, $1.status)
            }
        }
    }
    
    // filter the list by the given string
    func filterBy(string : String) -> [Restaurant]
    {
        return sort().filter({
            $0.name.lowercased().contains(string.lowercased())
        })
    }
    
}
