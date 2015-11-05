//  UserStaffController.swift
//  SmartQRes
//  Created by Kamnung Pitukkorn on 1/27/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.

import Foundation

class CustomerController {
    
    var queryPredicate:NSPredicate!
    var currentCust = Customer()
    var customerList: [Customer] = []
    var filteredListItems = [Customer]()
    var authen = false
    var currentCustId : NSNumber = 0
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    var prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    init() {
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Customer", forClassName: NSStringFromClass(Customer.classForCoder()))
        
        self.datastore.createIndexWithName("CustomerIndex", fields: ["cus_id", "cus_email","cus_password"], completionHandler: { (error:NSError!) -> Void in
        })
    }
    
    
    func authenMethod(email: String, password: String, uiView: LogInViewController){
        print("CUSTOMER CONTROLLER [AUTHEN METHOD]")
        
        var query : CDTQuery
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        self.queryPredicate = NSPredicate(format: "(cus_email = %@ AND cus_password = %@)", email, password)
        
        query = CDTCloudantQuery(dataType: "Customer", withPredicate: self.queryPredicate)
        self.datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR in authen method")
                print(error)
                
            }
            else{
                self.customerList = results as! [Customer]
                print("Customer List Count : \(self.customerList.count)")
                for i in 0..<self.customerList.count {
                    let item = self.customerList[i] as Customer
                    self.currentCustId = self.customerList[0].cus_id
                    
                    print("<---------------- UserName: \(item.cus_email) -------------->")
                    print("<---------------- Password: \(item.cus_password) -------------->")
                    
                    
                }
                self.reloadLocalTableData()
                
            }
            
        })
        
        
    }
    
    func reloadLocalTableData() {
        self.filteredListItems = self.customerList
        
        if (self.filteredListItems.count==0){
            print("Unknown User")
            
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.setBool(false, forKey: "AUTHEN")
            prefs.synchronize()
        
        }
        else{
            print("Authorized User")
            let item = self.filteredListItems[0] as Customer
            self.authen = true
            
            prefs.setInteger(1, forKey: "ISLOGGEDIN")
            prefs.setBool(true, forKey: "AUTHEN")
            prefs.setInteger(self.currentCustId.integerValue, forKey: "CURRENTCUSTID")
            prefs.synchronize()
        }
        
    }

    
    func checkDuplicateMethod(email: String, uiView: RegistrationViewController){
        print("Customer CONTROLLER [checkDuplicateMethod] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Customer")
        self.queryPredicate = NSPredicate(format: "(cus_email = %@)", email)
        
        query = CDTCloudantQuery(dataType: "Customer", withPredicate: self.queryPredicate)
        self.datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR in authen method")
                print(error)
                
            }
            else{
                var custList = results as! [Customer]
                if(results.count == 0){
                    uiView.duplicateUser = false
                }else{
                    uiView.duplicateUser = true
                }
                
            }
            
        })

        
    }
    
    func getCustomerById(cus_id: NSNumber, uiView: ProfileTableViewController){
        print("CUSTOMER CONTROLLER [getCustomer] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(cus_id = %@)", cus_id)
        query = CDTCloudantQuery(dataType: "Customer", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
            }
            else{
                self.customerList = results as! [Customer]
                if(self.customerList.count != 1){
                    print("Found more than one branch [id = \(cus_id)]")
                    
                }else{
                    self.currentCust = self.customerList[0]
                    uiView.cust = self.currentCust
                }
            }
            
        })
        
        
    }
    
    
    
    func createCustomer(email: String, firstname: String, lastname: String, mobilePhone: String, password: String, uiView: RegistrationViewController){
        print("Customer CONTROLLER [createCustmoer]")
        
        //Get Maximum ID
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var cust : Customer = Customer()
        
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Customer")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR --> \(error) ")
            }
            else{
                self.customerList = results as! [Customer]
                
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.customerList)
                let sd = NSSortDescriptor(key: "cus_id", ascending: true)
                os.sortUsingDescriptors([sd])
                self.customerList = os.array as! [Customer]
                
                var temp : Customer = Customer()
                temp = self.customerList[self.customerList.count-1]
                cust.cus_id = temp.cus_id.integerValue + 1
                
            }
        })

        NSThread.sleepForTimeInterval(0.5)
       
        cust.cus_email = email
        cust.cus_firstname = firstname
        cust.cus_lastname = lastname
        cust.cus_mobile_no = mobilePhone
        cust.cus_password = password
        cust.cus_dob = NSDate()
        self.datastore.save(cust, completionHandler: {(object, error) -> Void in
            if(error != nil){
                print("Error on create Customer: \(error)")
                
            }else{
                print("Create Customer Successfully.")
                uiView.createResult = true
            }
            
        })
        
        self.instance.pushItems()
    }
    
}