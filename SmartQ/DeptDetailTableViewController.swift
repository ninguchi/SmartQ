//
//  DeptDetailTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class DeptDetailTableViewController: UITableViewController , UISearchBarDelegate, UISearchDisplayDelegate {
    
    // let instance = SingletonClass.shared
    
    //Outlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchRest: UITableView!
    //Variable
    var mallName = ""
    var mallId : NSNumber = 0
//    let restNames = ["CoCo ICHIBANYA","Fuji","MK","OISHI","Sizzler","Sukishi"]
    var restNamesFilters = [Branch]()
    
    var branchList : [Branch] = []
    
    //var mall:ShoppingMall
    override func viewDidLoad() {
        super.viewDidLoad()
        BranchController().getBranchListByShoId(mallId, uiView: self)
        
        print("Dept Detail Table View Controller")
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        //Set bar color
        self.searchBar?.barTintColor = UIColor(red: (235/255.0), green: (129/255.0), blue: (24/255.0), alpha: 1.0)
        self.searchBar?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        self.title = mallName
        // set restaurant list
        /*
        var restCon = RestaurantController()
        var restNames = restCon.getRestaurantListByShoppingMallId(instance.connectionSmartQDB())
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            return self.restNamesFilters.count
        } else {
            return self.branchList.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.searchRest.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
        
        // Configure the cell...
        var restName:String
        if tableView == self.searchDisplayController!.searchResultsTableView {
            restName = self.restNamesFilters[indexPath.row].bra_res_name as String
        } else {
            restName = self.branchList[indexPath.row].bra_res_name as String
            
        }
        
        cell.textLabel!.text = restName
        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("branchDeptDetailSegue", sender: tableView)
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
        self.restNamesFilters = self.branchList.filter({( branch: Branch) -> Bool in
            let stringMatch = branch.bra_res_name.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
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
        if(segue.identifier == "branchDeptDetailSegue"){
            let branchDetailViewController = segue.destinationViewController as! BranchDetailViewController
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!
                
                let branchId = self.restNamesFilters[indexPath.row].bra_id
                let branchServiceTime = self.restNamesFilters[indexPath.row].bra_service_time
                let branchTbTypeA = "(\(self.restNamesFilters[indexPath.row].bra_ty_a_min) - \(self.restNamesFilters[indexPath.row].bra_ty_a_max) )"
                let branchTbTypeB = "(\(self.restNamesFilters[indexPath.row].bra_ty_b_min) - \(self.restNamesFilters[indexPath.row].bra_ty_b_max) )"
                let branchTbTypeC = "(\(self.restNamesFilters[indexPath.row].bra_ty_c_min) - \(self.restNamesFilters[indexPath.row].bra_ty_c_max) )"
                let branchTbTypeD = "(\(self.restNamesFilters[indexPath.row].bra_ty_d_min) - \(self.restNamesFilters[indexPath.row].bra_ty_d_max) )"
                
                let restName = self.restNamesFilters[indexPath.row].bra_res_name
                let locationName = self.restNamesFilters[indexPath.row].bra_location
                branchDetailViewController.branchId = branchId
                branchDetailViewController.branchServiceTime = branchServiceTime as! String
                branchDetailViewController.branchTbTypeA = branchTbTypeA
                branchDetailViewController.branchTbTypeB = branchTbTypeB
                branchDetailViewController.branchTbTypeC = branchTbTypeC
                branchDetailViewController.branchTbTypeD = branchTbTypeD
                
                branchDetailViewController.restName = restName as! String
                branchDetailViewController.locationName = locationName as! String
                branchDetailViewController.branchName = self.branchList[indexPath.row].bra_name as! String
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let branchId = self.branchList[indexPath.row].bra_id
                let branchServiceTime = self.branchList[indexPath.row].bra_service_time
                let branchTbTypeA = "(\(self.branchList[indexPath.row].bra_ty_a_min) - \(self.branchList[indexPath.row].bra_ty_a_max) )"
                let branchTbTypeB = "(\(self.branchList[indexPath.row].bra_ty_b_min) - \(self.branchList[indexPath.row].bra_ty_b_max) )"
                let branchTbTypeC = "(\(self.branchList[indexPath.row].bra_ty_c_min) - \(self.branchList[indexPath.row].bra_ty_c_max) )"
                let branchTbTypeD = "(\(self.branchList[indexPath.row].bra_ty_d_min) - \(self.branchList[indexPath.row].bra_ty_d_max) )"
                
                let restName = self.branchList[indexPath.row].bra_res_name
                let locationName = self.branchList[indexPath.row].bra_location
                branchDetailViewController.branchId = branchId
                branchDetailViewController.branchServiceTime = branchServiceTime as! String
                branchDetailViewController.branchTbTypeA = branchTbTypeA
                branchDetailViewController.branchTbTypeB = branchTbTypeB
                branchDetailViewController.branchTbTypeC = branchTbTypeC
                branchDetailViewController.branchTbTypeD = branchTbTypeD
                
                branchDetailViewController.restName = restName as! String
                branchDetailViewController.locationName = locationName as! String
                branchDetailViewController.branchName = self.branchList[indexPath.row].bra_name as! String
            }
            
        }
    }
    
}
