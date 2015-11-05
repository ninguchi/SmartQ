//
//  DataConnection.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 1/25/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

class SingletonClass {
    class var shared : SingletonClass {
        
        struct Static {
            static let instance : SingletonClass = SingletonClass()
        }
        
        return Static.instance
    }
    var authen = false
    var dbName:String = "smartqdb"
    var itemList: [UserStaff] = []
    var filteredListItems = [UserStaff]()
    var datastore: CDTStore!
    var remoteStore: CDTStore!
    var replicatorFactory: CDTReplicatorFactory!
    
    var pullReplication: CDTPullReplication!
    var pullReplicator: CDTReplicator!
    
    var pushReplication: CDTPushReplication!
    var pushReplicator: CDTReplicator!
    
    var doingPullReplication: Bool!
    var branch: BranchController!
    
    func connectionSmartQDB() -> CDTStore {
        var dbError:NSError?
        var access:NSString = "admins"
        let manager = IMFDataManager.sharedInstance() as IMFDataManager
        do{
        self.datastore = try manager.localStore(self.dbName)
        } catch _ {
        }
        if ((dbError) != nil) {
            print(dbError)
            
        }
        print("------------------------------------------------------")
        manager.remoteStore(dbName, completionHandler: { (store, error) -> Void in
            if (error != nil) {
                
                print(error)
                
            } else {
                
                self.remoteStore = store
                let authmanager = IMFAuthorizationManager.sharedInstance()
                authmanager.obtainAuthorizationHeaderWithCompletionHandler({ (response:IMFResponse!, error:NSError!) -> Void in
                    if ((error) != nil) {
                        print(error)
                        print(error.userInfo)
                    }
                    else {
                        //lets make sure we have an user id before transitioning, IMFDataManager needs this for permissions
                        if let userIdentity = authmanager.userIdentity as NSDictionary?
                        {
                            if let userid = userIdentity.valueForKey("id") as? String {
                                //print("user id = \(userid)")
                                manager.setCurrentUserPermissions(DB_ACCESS_GROUP_ADMINS, forStoreName: self.dbName, completionHander: { (success, error) -> Void in
                                    if (error != nil) {
                                        print(error)
                                    }
                                    self.replicatorFactory = manager.replicatorFactory
                                    self.pullReplication = manager.pullReplicationForStore(self.dbName)
                                    self.pushReplication = manager.pushReplicationForStore(self.dbName)
                                    //dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        self.pullItems()
                                        print("------------------------------------------------------")
                                   // })
                                })
                                
                            }
                            
                        }
                    }
                })
                
            }
            
        })
        return datastore
    }
    
    func pullItems() {
        do{
        self.pullReplicator = try self.replicatorFactory.oneWay(self.pullReplication)
        } catch _ {
            print("Error creating oneWay pullReplicator")
        }
        self.doingPullReplication = true
        
        do {
        try self.pullReplicator.startWithError()
        } catch _ {
            print("Error starting pullReplicator")
        }
    }
    
    func pushItems() {
        do {
            self.pushReplicator = try self.replicatorFactory.oneWay(self.pushReplication)
        } catch _ {
            print("Error creating oneWay pullReplicator")
        }
        
        self.doingPullReplication = false
        do{
            try self.pushReplicator.startWithError()
        } catch _ {
           print("Error starting pushReplicator")
        }
        
    }
    
}