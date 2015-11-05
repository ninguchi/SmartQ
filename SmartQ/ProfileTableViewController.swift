//
//  ProfileTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/17/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var labelFirstname: UILabel!
    @IBOutlet weak var labelLastname: UILabel!
    @IBOutlet weak var labelMobile: UILabel!
    @IBOutlet weak var labelDOB: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelPassword: UILabel!
    
    var cust : Customer = Customer()
    
    var cust_Firstname : String = ""
    var cust_Lastname : String = ""
    var cust_Email : String = ""
    var cust_Mobile : String = ""
    var cust_Password : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("PRESS Confirm Button")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentCustId:NSNumber = prefs.integerForKey("CURRENTCUSTID") as NSNumber
        
        var nav = self.navigationController?.navigationBar
         nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        
        CustomerController().getCustomerById(currentCustId, uiView: self)
        NSThread.sleepForTimeInterval(0.5)
        
        labelEmail.text = cust.cus_email as String
        labelFirstname.text = cust.cus_firstname as String
        labelLastname.text = cust.cus_lastname as String
        labelMobile.text = cust.cus_mobile_no as String
        labelPassword.text = cust.cus_password as String
        
        cust_Firstname = cust.cus_firstname as String
        cust_Lastname = cust.cus_lastname as String
        cust_Email = cust.cus_email as String
        cust_Mobile = cust.cus_mobile_no as String
        cust_Password = cust.cus_password as String
        
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
/*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
*/
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
        print("PUSH SEGUE")
        (segue.destinationViewController as! EditProfileTableViewController).ed_cust_Firstname = self.cust_Firstname as String
        (segue.destinationViewController as! EditProfileTableViewController).ed_cust_Lastname = self.cust_Lastname as String
        (segue.destinationViewController as! EditProfileTableViewController).ed_cust_Mobile = self.cust_Mobile as String
        (segue.destinationViewController as! EditProfileTableViewController).ed_cust_Email = self.cust_Email as String
        (segue.destinationViewController as! EditProfileTableViewController).ed_cust_Password = self.cust_Password as String
        
    }
    

}
