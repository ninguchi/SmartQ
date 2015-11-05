//  CurrentRunningNoController.swift

//  SmartQ

//

//  Created by Worayut Traiworadecha on 2/6/2558 BE.

//  Copyright (c) 2558 BlueSeed. All rights reserved.

//



import Foundation



public class CurrentRunningNoController{
    
    var currentRunningNo : CurrentRunningNo = CurrentRunningNo()
    var currentRunningNoList : [CurrentRunningNo] = []
    var queryPredicate : NSPredicate!
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init(){
        
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("CurrentRunningNo", forClassName: NSStringFromClass(CurrentRunningNo.classForCoder()))
        
        self.datastore.createIndexWithName("CurrentRunningNoIndex", fields: ["cur_bra_id"], completionHandler: { (error:NSError!) -> Void in
        })

    }
    
    func getCurrentRunningNoByBraId(cur_bra_id : NSNumber, uiView: BranchDetailViewController) -> Void {
        
        print("CURRENTRUNNINGNO CONTROLLER [getCurrentRunningNoByBraId] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cur_bra_id = %@)", cur_bra_id)
        query = CDTCloudantQuery(dataType: "CurrentRunningNo", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query CurrentRunningNo by braId = \(cur_bra_id)")
                
            }else{
                self.currentRunningNoList = results as! [CurrentRunningNo]
                if(self.currentRunningNoList.count != 1){
                    print("Found more than one CurrentRunningNo \(self.currentRunningNoList.count) for bra_id = \(cur_bra_id)")
                }else{
                    self.currentRunningNo = self.currentRunningNoList[0]
                    print("Current Running for bra_id \(cur_bra_id) -> [A: \(self.currentRunningNo.cur_ty_a)] [B: \(self.currentRunningNo.cur_ty_b)] [C: \(self.currentRunningNo.cur_ty_c)] [D: \(self.currentRunningNo.cur_ty_d)]")
                    
                    uiView.runningQA = self.currentRunningNo.cur_ty_a
                    uiView.runningQB = self.currentRunningNo.cur_ty_b
                    uiView.runningQC = self.currentRunningNo.cur_ty_c
                    uiView.runningQD = self.currentRunningNo.cur_ty_d
                 
                    uiView.tableCurrentQ.reloadData()
                }
            }
            
        })
        
    }
    
    func getCurrentRunningNoByBraId(cur_bra_id : NSNumber, uiView: BookingViewController) -> Void {
        
        print("CURRENTRUNNINGNO CONTROLLER [getCurrentRunningNoByBraId] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cur_bra_id = %@)", cur_bra_id)
        query = CDTCloudantQuery(dataType: "CurrentRunningNo", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query CurrentRunningNo by braId = \(cur_bra_id)")
                
            }else{
                self.currentRunningNoList = results as! [CurrentRunningNo]
                if(self.currentRunningNoList.count != 1){
                    print("Found more than one CurrentRunningNo \(self.currentRunningNoList.count) for bra_id = \(cur_bra_id)")
                }else{
                    self.currentRunningNo = self.currentRunningNoList[0]
                    print("Current Running for bra_id \(cur_bra_id) -> [A: \(self.currentRunningNo.cur_ty_a)] [B: \(self.currentRunningNo.cur_ty_b)] [C: \(self.currentRunningNo.cur_ty_c)] [D: \(self.currentRunningNo.cur_ty_d)]")
                    
                    uiView.currentRunningNo = self.currentRunningNo
                    
                }
            }
            
        })
        
    }
    
    /*
    func getCurrentRunningNoByBraId(cur_bra_id : NSNumber, tb_type: NSString) -> Void {
        
        print("CURRENTRUNNINGNO CONTROLLER [getCurrentRunningNoByBraId] ")
        
        self.instance.pullReplicator.delegate = uiView
        self.instance.pullItems()
        NSThread.sleepForTimeInterval(0.5)
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cur_bra_id = %@)", cur_bra_id)!
        query = CDTCloudantQuery(dataType: "CurrentRunningNo", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query CurrentRunningNo by braId = \(cur_bra_id)")
                
            }else{
                self.currentRunningNoList = results as [CurrentRunningNo]
                if(self.currentRunningNoList.count != 1){
                    print("Found more than one CurrentRunningNo \(self.currentRunningNoList.count) for bra_id = \(cur_bra_id)")
                }else{
                    self.currentRunningNo = self.currentRunningNoList[0]
                    print("Current Running for bra_id \(cur_bra_id) -> [A: \(self.currentRunningNo.cur_ty_a)] [B: \(self.currentRunningNo.cur_ty_b)] [C: \(self.currentRunningNo.cur_ty_c)] [D: \(self.currentRunningNo.cur_ty_d)]")
                    
                }
            }
            
        })
        
    }
*/
    func createCurrentRunningNo(currentObj : CurrentRunningNo) -> Void {
        print("CURRENTRUNNINGNO CONTROLLER [createCurrentRunningNo] ")
        datastore.save(currentRunningNo, completionHandler: { (object, error) -> Void in
            
            if(error != nil){
                //self.logger.logErrorWithMessages("createItem failed with error \(error.description)")
                print("Error on update currentRunningNo \(error)")
                
            } else {
                self.currentRunningNo = object as! CurrentRunningNo
                print("Update currentRunningNo Successfully")
                
            }
        })
        self.instance.pushItems()

        
    }
    
    
    
    func updateCurrentRunningNo(currentRunningNo : CurrentRunningNo) -> Void {
        print("CURRENTRUNNINGNO CONTROLLER [updateCurrentRunningNo] ")
        datastore.save(currentRunningNo, completionHandler: { (object, error) -> Void in
            
            if(error != nil){
                //self.logger.logErrorWithMessages("createItem failed with error \(error.description)")
                print("Error on update currentRunningNo \(error)")
                
            } else {
                self.currentRunningNo = object as! CurrentRunningNo
                print("Update currentRunningNo Successfully")
                
            }
        })
        self.instance.pushItems()
        
    }
    
}