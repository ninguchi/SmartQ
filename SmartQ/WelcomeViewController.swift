//
//  WelcomeViewController.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 2/13/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
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
    var queryPredicate:NSPredicate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        print("WelcomeViewController [ViewDidAppear]")
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("loginSegue", sender: self)
        } else {
 
            let isAuthen:Bool = prefs.boolForKey("AUTHEN") as Bool
            if (isAuthen){
                print("WELCOME CONTROLLER : Authen Pass")
                let currentCustId = prefs.integerForKey("CURRENTCUSTID") as Int
                
                self.performSegueWithIdentifier("homeSegue", sender: self)
                
                
            }else{
                print("WELCOME CONTROLLER : Authen Fail")

                
                let alert = UIAlertView()
                alert.title = "Authentication"
                alert.message = "Username/Password is incorrect"
                alert.addButtonWithTitle("OK")
                alert.show()
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
