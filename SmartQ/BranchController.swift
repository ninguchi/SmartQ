//
//  BranchController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/5/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation
class BranchController{
    
    var queryPredicate:NSPredicate!
    var branch = Branch()
    var branchList : [Branch] = []
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Branch", forClassName: NSStringFromClass(Branch.classForCoder()))
        
        self.datastore.createIndexWithName("BranchIndex", fields: ["bra_res_id", "bra_sho_id"], completionHandler: { (error:NSError!) -> Void in
        })
    }

    
//    func getBranchList(var datastore: CDTStore!) -> [Branch] {
//        var query : CDTQuery
//        query = CDTCloudantQuery(dataType: "Branch")
//        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
//            if((error) != nil){
//                print(error)
//            }
//            else{
//                self.branchList = results as [Branch]
//                
//            }
//        })
//        
//        
//        return self.branchList
//    }

    func getAllBranch(uiView: MyQueueTableViewController) -> Void {
        print("BRANCH CONTROLLER [getAllBranch]")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Branch")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                print("branch count : \(self.branchList.count)")
                uiView.branchList = self.branchList
                
            }
        })
        
    }
    
    
    func getBranchById(bra_id : NSNumber, uiView: BookingViewController) -> Void {
        print("BRANCH CONTROLLER [getBranchListById] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                if(self.branchList.count != 1){
                    print("Found more than one branch [id = \(bra_id)]")
                    
                }else{
                    self.branch = self.branchList[0]
                    uiView.branchObj = self.branch
                }
            }
            
        })
        
    }
    
    
    
    
    func getBranchById(bra_id : NSNumber, uiView: MyQueueTableViewController) -> Void {
        print("BRANCH CONTROLLER [getBranchListById] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_id = %@)", bra_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.branchList = results as! [Branch]
                if(self.branchList.count != 1){
                    print("Found more than one branch [id = \(bra_id)]")
                    
                }else{
                    self.branch = self.branchList[0]
                    uiView.branchObj = self.branch
                }
            }
            
        })
        
    }
    
    func getBranchListByResId(bra_res_id : NSNumber, uiView: RestDetailTableViewController) -> Void {
        print("BRANCH CONTROLLER [getBranchListByResId] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_res_id = %@)", bra_res_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query branch by bra_res_id \(error) ")
            }else{
                print("Found \(results.count) Branch for bra_res_id = \(bra_res_id) ")
                self.branchList = results as! [Branch]
                
                //Order by branch name
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.branchList)
                let sd = NSSortDescriptor(key: "bra_name", ascending: true)
                os.sortUsingDescriptors([sd])
                self.branchList = os.array as! [Branch]

                
                uiView.branchList = self.branchList
                uiView.tableView.reloadData()
            }
        })
       
        
    }
    
    func getBranchListByShoId(bra_sho_id: NSNumber, uiView: DeptDetailTableViewController) -> Void {
        print("BRANCH CONTROLLER [getBranchListByShoId] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(bra_sho_id = %@)", bra_sho_id)
        query = CDTCloudantQuery(dataType: "Branch", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query branch by bra_sho_id \(error)")
                
            }else{
                print("Found \(results.count) Branch for bra_sho_id = \(bra_sho_id)")
                self.branchList = results as! [Branch]
                
                uiView.branchList = self.branchList
                uiView.tableView.reloadData()
            }
        
        
        })
        
        
    }
    
    
}