//
//  MainRestListTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class MainRestListTableViewController: UITableViewController {
    //let instance = SingletonClass.shared
//    let restNames = ["CoCo ICHIBANYA","Fuji","MK","OISHI","Sizzler","Sukishi"]
    var restaurantList : [Restaurant] = []
    
//    var dbName:String = "smartqdb"
//    var datastore: CDTStore!
//    var remoteStore: CDTStore!
//    var replicatorFactory: CDTReplicatorFactory!
//    
//    var pullReplication: CDTPullReplication!
//    var pullReplicator: CDTReplicator!
//    
//    var pushReplication: CDTPushReplication!
//    var pushReplicator: CDTReplicator!
//    
//    var doingPullReplication: Bool!
    
    //var restNames = [Restaurant]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        RestaurantController().getRestaurantList(self)
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        nav?.backItem?.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Heiti SC", size: 15)!], forState: .Normal)
        
        self.title = "Restaurant List"
        
//        self.refreshControl = UIRefreshControl()
//        self.refreshControl?.addTarget(self, action: Selector("handleRefreshAction") , forControlEvents: UIControlEvents.ValueChanged)
//        self.refreshControl?.beginRefreshing()
//        
//        self.setupIMFDatabase(self.dbName)
        // set restaurant list
        /*
        var restCon = RestaurantController()
        var restNames = restCon.getRestaurantList(instance.connectionSmartQDB())
*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return restaurantList.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
//        let fn = restNames[indexPath.row] + ".jpg"
//        
//        cell.imageView!.image = UIImage(named: fn)
//        cell.textLabel!.text = restNames[indexPath.row]
//        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
//        return cell
    
        let image = self.restaurantList[indexPath.row].res_name as! String + ".jpg"
        cell.imageView!.image = UIImage(named: image)
        cell.textLabel!.text = self.restaurantList[indexPath.row].res_name as String
        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    // MARK: - Back from Confirm Booking Q
    @IBAction func doneFromConfirmBookingMethod(segue: UIStoryboardSegue){
        print("Restaurant - Done from confirm Booking Method.")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let restName = restaurantList[indexPath.row].res_name as String
            let restId = restaurantList[indexPath.row].res_id as NSNumber
            let restDetailTableViewController = segue.destinationViewController as! RestDetailTableViewController
            restDetailTableViewController.restName = restName
            restDetailTableViewController.restId = restId
            // restDetailTableViewController.rest = restNames[indexPath.row]
            
        }
        
    }
    
//    func pullItems() {
//        var error:NSError?
//        self.pullReplicator = self.replicatorFactory.oneWay(self.pullReplication, error: &error)
//        if(error != nil){
//            print("Error creating oneWay pullReplicator \(error)")
//        }
//        
//        self.pullReplicator.delegate = self
//        self.doingPullReplication = true
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull Items from Cloudant")
//        
//        error = nil
//        print("Replicating data with NoSQL Database on the cloud")
//        self.pullReplicator.startWithError(&error)
//        if(error != nil){
//            print("Error starting pullReplicator \(error)")
//        }
//    }
//    
//    func pushItems() {
//        var error:NSError?
//        self.pushReplicator = self.replicatorFactory.oneWay(self.pushReplication, error: &error)
//        if(error != nil){
//            print("Error creating oneWay pullReplicator \(error)")
//        }
//        
//        self.pushReplicator.delegate = self
//        self.doingPullReplication = false
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pushing Items to Cloudant")
//        
//        error = nil
//        self.pushReplicator.startWithError(&error)
//        if(error != nil){
//            print("Error starting pushReplicator \(error)")
//        }
//        
//        
//    }
//    
//    // MARK: - CDTReplicator delegate methods
//    
//    /**
//    * Called when the replicator changes state.
//    */
//    func replicatorDidChangeState(replicator: CDTReplicator!) {
//        print("replicatorDidChangeState \(CDTReplicator.stringForReplicatorState(replicator.state))")
//    }
//    
//    /**
//    * Called whenever the replicator changes progress
//    */
//    func replicatorDidChangeProgress(replicator: CDTReplicator!) {
//        
//        print("replicatorDidChangeProgress \(CDTReplicator.stringForReplicatorState(replicator.state))")
//        
//    }
//    
//    /**
//    * Called when a state transition to COMPLETE or STOPPED is
//    * completed.
//    */
//    func replicatorDidComplete(replicator: CDTReplicator!) {
//        print("replicatorDidComplete \(CDTReplicator.stringForReplicatorState(replicator.state))")
//        
//        if self.doingPullReplication! {
//            //done doing pull, lets start push
//            self.pushItems()
//        } else {
//            //doing push, push is done read items from local data store and end the refresh UI
//            self.listItems({ () -> Void in
//                print("Done refreshing table after replication")
//                self.refreshControl?.endRefreshing()
//                //self.settingsButton.enabled = true
//            })
//        }
//        
//    }
//    
//    /**
//    * Called when a state transition to ERROR is completed.
//    */
//    
//    func replicatorDidError(replicator: CDTReplicator!, info: NSError!) {
//        self.refreshControl?.attributedTitle = NSAttributedString(string: "Error replicating with Cloudant")
//        print("replicatorDidError \(info)")
//        self.listItems({ () -> Void in
//            print("")
//            self.refreshControl?.endRefreshing()
//        })
//    }
//
//    func setupIMFDatabase(dbName: NSString) {
//        var dbError:NSError?
//        let manager = IMFDataManager.sharedInstance() as IMFDataManager
//        
//        self.datastore = manager.localStore(dbName, error: &dbError)
//        if ((dbError) != nil) {
//            print("Error creating local data store \(dbError)")
//        }
//        
//        self.datastore.mapper.setDataType("Restaurant", forClassName: NSStringFromClass(Restaurant.classForCoder()))
//        
//        if (!IBM_SYNC_ENABLE) {
//            self.listItems({ () -> Void in
//                print("Done refreshing we are not using cloud")
//                self.refreshControl?.endRefreshing()
//            })
//            return
//        }
//        manager.remoteStore(dbName, completionHandler: { (store, error) -> Void in
//            if (error != nil) {
//                print("Error creating remote data store \(error)")
//            } else {
//                self.remoteStore = store
//                manager.setCurrentUserPermissions(DB_ACCESS_GROUP_ADMINS, forStoreName: dbName, completionHander: { (success, error) -> Void in
//                    if (error != nil) {
//                        print("Error setting permissions for user with error \(error)")
//                    }
//                    self.replicatorFactory = manager.replicatorFactory
//                    self.pullReplication = manager.pullReplicationForStore(dbName)
//                    self.pushReplication = manager.pushReplicationForStore(dbName)
//                    self.pullItems()
//                })
//            }
//            
//        })
//    }
//    
//    func listItems(cb:()->Void) {
//        print("listItems called")
//        var query:CDTQuery
//        query = CDTCloudantQuery(dataType: "Restaurant")
//        self.datastore.performQuery(query, completionHandler: { (results, error) -> Void in
//            if((error) != nil) {
//                print("listItems failed with error \(error.description)")
//            }
//            else{
//                self.restaurantList = results as [Restaurant]
//                print("Found Restaurant \(results.count)")
//                var i = 0
//                for( i = 0 ; i < results.count ; i++){
//                    print("\(self.restaurantList[i].res_name)")
//                }
//                self.reloadLocalTableData()
//            }
//            cb()
//        })
//    }
//    func reloadLocalTableData() {
//        //self.filterContentForPriority(scope: self.segmentFilter.titleForSegmentAtIndex(self.segmentFilter.selectedSegmentIndex)!)
//        /*self.filteredListItems.sort { (item1: Restaurant, item2: Restaurant) -> Bool in
//        return item1.name.localizedCaseInsensitiveCompare(item2.name) == .OrderedAscending
//        }*/
//        if self.tableView != nil {
//            self.tableView.reloadData()
//        }
//    }
//    
//    func handleRefreshAction()
//    {
//        if (IBM_SYNC_ENABLE) {
//            self.pullItems()
//        } else {
//            self.listItems({ () -> Void in
//                print("Done refreshing table in handleRefreshAction")
//                self.refreshControl?.endRefreshing()
//            })
//        }
//    }

}
