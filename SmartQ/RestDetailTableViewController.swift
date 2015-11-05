//
//  RestDetailTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//  Commit File from Ning

import UIKit

class RestDetailTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
   // let instance = SingletonClass.shared
    
    // Outlet
    @IBOutlet weak var searchBranchList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // Variable
    var restName : String = ""
    var restId : NSNumber = 0
    
//    let branchNames = ["Siam Paragon", "Siam Center", "Central World", "MBK", "Central Rama 2", "Central Rama 3"]
    var branchNamesFilters = [Branch]()
    
    var branchList : [Branch] = []
    
    
    //var rest : Restaurant
    //var branchNames = [Branch]()
    //var branchNamesFilters = [Branch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = restName
        
        //Set Backgroup color and font style for Navigation Bar
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        //Set bar color
        self.searchBar?.barTintColor = UIColor(red: (235/255.0), green: (129/255.0), blue: (24/255.0), alpha: 1.0)
        self.searchBar?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        //searchbar.tintColor = [UIColor greenColor];
        //nav?.backItem?.backBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Heiti SC", size: 15)!], forState: .Normal)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        // set branch list
        print("REST Detail Table View Controller [ViewDidLoad] restId : \(self.restId)")
        BranchController().getBranchListByResId(self.restId, uiView: self)
    }
    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }*/
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
            return self.branchNamesFilters.count
        } else {
            return self.branchList.count
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.searchBranchList.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell!
        
        // Configure the cell...
        var branchName:String
        if tableView == self.searchDisplayController!.searchResultsTableView {
            branchName = self.branchNamesFilters[indexPath.row].bra_name as String
        } else {
            branchName = self.branchList[indexPath.row].bra_name as String
        }
        cell.textLabel!.text = branchName
        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Did Select Row At Index Path")
        self.performSegueWithIdentifier("branchRestDetailSegue", sender: tableView)
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
        self.branchNamesFilters = self.branchList.filter({( branch: Branch) -> Bool in
            let stringMatch = branch.bra_name.lowercaseString.rangeOfString(searchText.lowercaseString)
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
        /*
        if let indexPath = self.tableView.indexPathForSelectedRow() {
        var branchName:String
        if tableView == self.searchDisplayController!.searchResultsTableView {
        branchName = self.branchNamesFilters[indexPath.row]
        } else {
        branchName = self.branchNames[indexPath.row]
        }
        (segue.destinationViewController as BranchDetailViewController).branchName = branchName
        }*/
        if(segue.identifier == "branchRestDetailSegue"){
            let branchDetailViewController = segue.destinationViewController as! BranchDetailViewController
            
            if sender as! UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow!
                let branchName = self.branchNamesFilters[indexPath.row].bra_name
                let branchId = self.branchNamesFilters[indexPath.row].bra_id
                let branchServiceTime = self.branchNamesFilters[indexPath.row].bra_service_time
                let branchTbTypeA = "(\(self.branchNamesFilters[indexPath.row].bra_ty_a_min) - \(self.branchNamesFilters[indexPath.row].bra_ty_a_max) )"
                let branchTbTypeB = "(\(self.branchNamesFilters[indexPath.row].bra_ty_b_min) - \(self.branchNamesFilters[indexPath.row].bra_ty_b_max) )"
                let branchTbTypeC = "(\(self.branchNamesFilters[indexPath.row].bra_ty_c_min) - \(self.branchNamesFilters[indexPath.row].bra_ty_c_max) )"
                let branchTbTypeD = "(\(self.branchNamesFilters[indexPath.row].bra_ty_d_min) - \(self.branchNamesFilters[indexPath.row].bra_ty_d_max) )"
                
                let restName = self.branchNamesFilters[indexPath.row].bra_res_name
                let locationName = self.branchNamesFilters[indexPath.row].bra_location
                
                branchDetailViewController.branchId = branchId
                
                branchDetailViewController.branchServiceTime = branchServiceTime as! String
                branchDetailViewController.branchTbTypeA = branchTbTypeA as String
                branchDetailViewController.branchTbTypeB = branchTbTypeB as String
                branchDetailViewController.branchTbTypeC = branchTbTypeC as String
                branchDetailViewController.branchTbTypeD = branchTbTypeD as String
                
                branchDetailViewController.branchName = branchName as! String
                branchDetailViewController.restName = restName as! String
                branchDetailViewController.locationName = locationName as! String
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let branchId = self.branchList[indexPath.row].bra_id
                let branchName = self.branchList[indexPath.row].bra_name
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
                
                branchDetailViewController.branchName = branchName as! String
                branchDetailViewController.restName = restName as! String
                branchDetailViewController.locationName = locationName as! String
                
                
            }
            
            branchDetailViewController.restName = self.restName
         
        }
        
        
        
    }

}
