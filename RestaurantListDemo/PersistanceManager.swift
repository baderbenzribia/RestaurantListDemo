//
//  PersistanceManager.swift
//  RestaurantListDemo
//
//  Created by Bader BEN ZRIBIA on 11.11.17.
//  Copyright © 2017 Bader BEN ZRIBIA. All rights reserved.
//

import Foundation

class PersistanceManager {
    
    // create a serial Queue for saving and fetching data from disk
    let serialQueue: DispatchQueue = DispatchQueue(label: "PersistanceQueue")
    
    // computed property to check if it is the first launch or not
    var isNotFirstLaunch : Bool
    {
        get {
            let standard = UserDefaults.standard
            return standard.bool(forKey: "isNotFirstLaunch")
        }
        set(value) {
            let standard = UserDefaults.standard
            standard.set(value, forKey: "isNotFirstLaunch")
            standard.synchronize()
        }
    }
    
    // save the restaurant array to documents-directory
    func saveRestaurantsToDisk(restaurants: [Restaurant]) {
        
        serialQueue.async() {
            
            // create a URL for documents-directory/restaurants.json
            let url = self.getDocumentsURL().appendingPathComponent("restaurants.json")
            // endcode our [Restaurant] data to JSON Data
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(restaurants)
                // write this data to the specified url
                try data.write(to: url, options: [])
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    // fetch the restaurant array from documents-directory
    func getRestaurantsFromDisk() -> [Restaurant] {
        
        var restaurants : [Restaurant] = []
        
        serialQueue.sync() {
            // create a URL for documents-directory/restaurants.json
            let url = getDocumentsURL().appendingPathComponent("restaurants.json")
        
            let decoder = JSONDecoder()
            do {
                // retrieve the data on the file in this path (if there is any)
                let data = try Data(contentsOf: url, options: [])
                // decode an array of Restaurants from this Data
                 restaurants = try decoder.decode([Restaurant].self, from: data)
                
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return restaurants
    }
    
    // fetch the restaurant array from the sample file
    func getRestaurantsFromSampleFile()-> [Restaurant]
    {
        // create a URL for the sample file
        let url = Bundle.main.url(forResource: "sample iOS", withExtension: "json")
        
        let decoder = JSONDecoder()
        do {
            // retrieve the data on the file in this path (if there is any)
            let data = try Data(contentsOf: url!)
            // decode an array of Restaurants from this Data
            let restaurantList = try decoder.decode(RestaurantList.self, from: data)
            
            return restaurantList.restaurants
        }
        catch {
            fatalError(error.localizedDescription)
        }
        
    }
    
    // get the URL for documents-directory
    func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
}
