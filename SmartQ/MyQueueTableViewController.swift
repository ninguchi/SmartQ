//
//  MyQueueTableViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class MyQueueTableViewController: UITableViewController,UISearchBarDelegate, UISearchDisplayDelegate {
    
    
    //logger
    var logger = IMFLogger(forName: "mytestlogger")
    var queueList : [Queue] = []
    var queueFilter = [String]()
    var branchObj : Branch = Branch()
    var branchList : [Branch] = []
    
    override func viewDidAppear(animated: Bool) {
        
        BranchController().getAllBranch(self)
        
        self.queueList.removeAll(keepCapacity: false)
    
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentCustId:NSNumber = prefs.integerForKey("CURRENTCUSTID") as NSNumber
        
        QueueController().getQueueByCusIdAndStatusId(currentCustId, statusId: Constants.QueueStatus.Waiting, uiView: self)
        QueueController().getQueueByCusIdAndStatusId(currentCustId, statusId: Constants.QueueStatus.Completed, uiView: self)
        QueueController().getQueueByCusIdAndStatusId(currentCustId, statusId: Constants.QueueStatus.NoShow, uiView: self)
        
        NSThread.sleepForTimeInterval(0.5)
        for i in 0..<self.queueList.count {
            var tempQ : Queue = self.queueList[i]
            print(">>>>>> \(tempQ.que_tb_type) \(tempQ.que_no) : [Branch Id: \(tempQ.que_bra_id) ]<<<<<")
            for j in 0..<self.branchList.count {
                var tempBr : Branch = self.branchList[j]
                print("   ---- Compare with \(tempBr.bra_id) ----- ")
                if(tempQ.que_bra_id == tempBr.bra_id){
                    print("   Found Branch \(tempBr.bra_id) ----- ")
                    tempQ.que_bra_name_display = tempBr.bra_name
                    tempQ.que_res_name_display = tempBr.bra_res_name
                    break
                }
                
            }
            
            self.queueList[i] = tempQ
            print("------ \(self.queueList[i].que_tb_type)\(self.queueList[i].que_no) -------- ")
            print("------ \(self.queueList[i].que_res_name_display) \(self.queueList[i].que_bra_name_display) -------")
        }
        
        print("===== TOTAL QUEUE : \(self.queueList.count) ===== ")
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Refresh Page
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: Selector("handleRefreshAction") , forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl?.beginRefreshing()
        
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        
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
        return self.queueList.count
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
//      
//        cell.textLabel!.text = self.queueList[indexPath.row].que_tb_type
//        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 15)
        
//        var queNo : String = ""
//        queNo = "\(self.queueList[indexPath.row].que_tb_type)"
//        cell.textLabel!.text = self.queueList[indexPath.row].que_tb_type
        print("========== Index Path: [\(self.queueList[indexPath.row].que_tb_type) \(self.queueList[indexPath.row].que_no)] ========== : \(self.queueList[indexPath.row].que_res_name_display) ======= \(self.queueList[indexPath.row].que_bra_id)")
        let image = self.queueList[indexPath.row].que_res_name_display as! String + ".jpg"
        cell.imageView!.image = UIImage(named: image)
        cell.textLabel!.font = UIFont(name: "Heiti SC", size: 17)
        cell.textLabel!.text = "\(self.queueList[indexPath.row].que_tb_type)\(self.queueList[indexPath.row].que_no.integerValue.format(Constants.DecimalFormat.Queue as! String)) [\(self.queueList[indexPath.row].que_bra_name_display)]";
        
        var detail : String = ""
        
        if(self.queueList[indexPath.row].que_status == Constants.QueueStatus.Waiting){
            detail = "[Status : \(Constants.QueueStatusName.WaitingStatus)]"
//            cell.backgroundColor! = UIColor(red: (254/255.0), green: (252/255.0), blue: (205/255.0), alpha: 0.5)
        
        }else if(self.queueList[indexPath.row].que_status == Constants.QueueStatus.Completed){
            detail =  "[Status : \(Constants.QueueStatusName.CompletedStatus)]"
            
        }else if(self.queueList[indexPath.row].que_status == Constants.QueueStatus.NoShow){
            detail =  "[Status : \(Constants.QueueStatusName.NoShowStatus)]"
        }
        
        cell.detailTextLabel!.text = detail
        cell.detailTextLabel!.font = UIFont(name: "Heiti SC", size: 12)
        
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        var queue : Queue = Queue()
        queue = self.queueList[indexPath.row]
        if(queue.que_status == Constants.QueueStatus.Waiting){
            return true
            
        }else{
            return false
        }
        
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            print("PRESS Cancel Q ")
            
            //Display success
            var alertController = UIAlertController(title: "", message: "Are you sure you want to delete this queue?", preferredStyle: .Alert)
            
            // Create the actions
            var deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Default) {
                UIAlertAction in
                NSLog("Delete Pressed")
                
                var queue : Queue = Queue()
                queue = self.queueList[indexPath.row]
                queue.que_status = Constants.QueueStatus.Cancelled
                queue.que_cancel_time = NSDate()
                QueueController().updateQueueStatus(queue, uiView: self)
                self.queueList.removeAtIndex(indexPath.row)
                self.tableView.reloadData()
                print("Delete Success")
//                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
            var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
                UIAlertAction in
                
            }
            
            // Add the actions
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            // Present the controller
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
//        else if editingStyle == .None {
//            //None == Remove from list
//            print("Remove From List")
//            var alertController = UIAlertController(title: "", message: "Are you sure you want to remove this queue from list", preferredStyle: .Alert)
//            
//            var removeAction = UIAlertAction(title: "", style: UIAlertActionStyle.Default){
//                UIAlertAction in
//                
//                
//            }
//            var cancelAction = UIAlertAction(title: "", style: UIAlertActionStyle.Cancel){
//                UIAlertAction in
//            }
//            
//            
//        }
        
    }
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var queue : Queue = self.queueList[indexPath.row]
        if(queue.que_status == Constants.QueueStatus.Waiting){
            
            var deleteButton = UITableViewRowAction(style: .Default, title: "Delete Q", handler: { (action, indexPath) in
                self.tableView.dataSource?.tableView?(
                    self.tableView,
                    commitEditingStyle: .Delete,
                    forRowAtIndexPath: indexPath
                )
                
                return
            })
            
            deleteButton.backgroundColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
            
            return [deleteButton]
            
        }else{
            
            return nil
            
        }
    }

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
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            BranchController().getBranchById(self.queueList[indexPath.row].que_bra_id, uiView: self)
            
            NSThread.sleepForTimeInterval(0.5)
            (segue.destinationViewController as! ConfirmBookingViewController).restName = self.queueList[indexPath.row].que_res_name_display as! String
            (segue.destinationViewController as! ConfirmBookingViewController).branchName = self.queueList[indexPath.row].que_bra_name_display as! String
            print(">>------ Branch Id : \(self.branchObj.bra_id) --------<<")
            (segue.destinationViewController as! ConfirmBookingViewController).locationName = self.branchObj.bra_location as! String
            (segue.destinationViewController as! ConfirmBookingViewController).branchObj = self.branchObj
            (segue.destinationViewController as! ConfirmBookingViewController).queueObj = self.queueList[indexPath.row]
            (segue.destinationViewController as! ConfirmBookingViewController).numberPerson = "\(self.queueList[indexPath.row].que_no_person)"
            (segue.destinationViewController as! ConfirmBookingViewController).serviceTime = self.branchObj.bra_service_time as! String
            (segue.destinationViewController as! ConfirmBookingViewController).sourceSegue = Constants.SourceSegue.MyQueueController as! String
        }
        
    }
    
    func handleRefreshAction()
    {
        self.viewDidAppear(true)
        self.refreshControl?.endRefreshing()
     
    }

    

}
