//
//  RestaurantController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class RestaurantController {
    var queryPredicate:NSPredicate!
    var restaurantList : [Restaurant] = []
    var restaurant = Restaurant()
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Restaurant", forClassName: NSStringFromClass(Restaurant.classForCoder()))
        
        self.datastore.createIndexWithName("RestuarantIndex", fields: ["res_id", "res_name"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    
    func getRestaurantList(uiView: MainRestListTableViewController) -> [Restaurant] {
        print("---- RESTAURANT CONTROLLER [getRestaurantList] ----")

        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()

        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Restaurant")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                NSThread.sleepForTimeInterval(0.5)
                
                self.restaurantList = results as! [Restaurant]
                
                print("restaurant count : \(self.restaurantList.count)")
                uiView.restaurantList = self.restaurantList
                
                uiView.tableView.reloadData()

            }
        })
        
        
        
        return self.restaurantList
        
    }
    
//    func getRestaurantById(res_id: NSNumber, uiView: DeptDetailTableViewController){
//        
//        self.instance.pullItems()
//        
//        var query : CDTQuery
//        self.queryPredicate = NSPredicate(format: "(res_id = %@)", res_id)!
//        query = CDTCloudantQuery(dataType: "Restaurant", withPredicate: self.queryPredicate)
//        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
//            if((error) != nil){
//                print(error)
//            }
//            else{
//                self.restaurantList = results as [Restaurant]
//                if(self.restaurantList.count != 1){
//                    print("Found more than one restaurant [id = \(res_id)]")
//                    
//                }else{
//                    self.restaurant = self.restaurantList[0]
//                }
//            }
//            
//        })
//        
//    }
    
    
    func createRestaurant(rest: Restaurant){
        print("RESTAURANT Controller [Create Restaurant Method] ")
        self.datastore.save(rest, completionHandler: {(object, error) -> Void in
            if(error != nil){
                print("Error on create Customer: \(error)")
                
            }else{
                print("Create Restaurant Successfully.")
                
            }
            
        })
        
        self.instance.pushItems()
    }

    

}
