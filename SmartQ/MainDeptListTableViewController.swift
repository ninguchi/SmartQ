//
//  MainDeptListTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//
import CoreLocation
import UIKit

class MainDeptListTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate, CLLocationManagerDelegate {
    
    // let instance = SingletonClass.shared
    
    //Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchLocationList: UITableView!
    
    
    let manager = CLLocationManager()
    var locationObj = CLLocation();
    
    //variable
//    let mallNames = ["Siam Paragon","Siam Center","Siam Square One","Central World","Central Rama 2","Central Rama 3", "The Mall Thapra", "Villa Aree"]
    var mallNamesFilters = [ShoppingMall]()
    
    var shoppingMallList : [ShoppingMall] = []
    
    
    //var mallNames = [ShoppingMall]()
    //var mallNamesFilters = [ShoppingMall]()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationObj = CLLocation(latitude: 13.781141,longitude:100.545264)
        if CLLocationManager.locationServicesEnabled() {
            self.manager.delegate = self
            self.manager.desiredAccuracy = kCLLocationAccuracyBest
            
            self.manager.requestAlwaysAuthorization()
            self.manager.startUpdatingLocation()
            
        }else{
            print("Don't Allow to get current location")
        }
        //ShoppingMallController().getShoppingMallList(self)
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        //Set bar color
        self.searchBar?.barTintColor = UIColor(red: (235/255.0), green: (129/255.0), blue: (24/255.0), alpha: 1.0)
        self.searchBar?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        self.title = "Shopping Mall List"
        
        // set shopping mall list
        /*
        var mallCon = ShoppingMallController()
        var mallNames = mallCon.getShoppingMallList(instance.connectionSmartQDB())
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        ShoppingMallController().getShoppingMallList(self)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        self.manager.stopUpdatingLocation()
        if ((error) != nil) {
            print(error)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locationArray = locations as NSArray
        locationObj = locationArray.lastObject as! CLLocation
        var coord = locationObj.coordinate
        //        print(coord.latitude)
        //        print(coord.longitude)

    }

    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
         self.view.endEditing(true)
    }
    */
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
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.mallNamesFilters.count
        } else {
            return self.shoppingMallList.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.searchLocationList.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
        
        // Configure the cell...
        var mallName:String
        var mallDistance:Double
        if tableView == self.searchDisplayController!.searchResultsTableView {
            mallName = self.mallNamesFilters[indexPath.row].sho_name as String
            mallDistance = self.mallNamesFilters[indexPath.row].sho_distance
        } else {
            mallName = self.shoppingMallList[indexPath.row].sho_name as String
            mallDistance = self.shoppingMallList[indexPath.row].sho_distance
        }
        cell.textLabel!.text = mallName
        cell.detailTextLabel!.text = String(format: "%.2f",mallDistance/1000)+" km"
        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
        cell.detailTextLabel!.font = UIFont(name: "Heiti SC", size: 13)
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Did Select Row At Index Path")
        self.performSegueWithIdentifier("deptRestSegue", sender: tableView)
    }
    
    // MARK: - Search Display Delegate
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text!)
        return true
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
       self.mallNamesFilters = self.shoppingMallList.filter({( mall: ShoppingMall) -> Bool in
            let stringMatch = mall.sho_name.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
    }
    
    
    // MARK: - Back from Confirm Booking Q
    @IBAction func doneFromConfirmBookingMethod(segue: UIStoryboardSegue){
        print("Department - Done from confirm Booking Method.")
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if let table = sender as? UITableView{
            print("Table View")
        }else{
            print("Not Table View")
        }
        
        if(segue.identifier == "deptRestSegue"){
            print("Dept Rest Segue")
            let deptDetailViewController = segue.destinationViewController as! DeptDetailTableViewController
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!
                let mallName = self.mallNamesFilters[indexPath.row].sho_name
                let mallId = self.mallNamesFilters[indexPath.row].sho_id
                
                deptDetailViewController.mallName = mallName as String
                deptDetailViewController.mallId = mallId
                
                
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let mallName = self.shoppingMallList[indexPath.row].sho_name
                let mallId = self.shoppingMallList[indexPath.row].sho_id
                
                deptDetailViewController.mallName = mallName as String
                deptDetailViewController.mallId = mallId
            }
            
            //(segue.destinationViewController as DeptDetailTableViewController).mallName = mallName
        }
    }
}
