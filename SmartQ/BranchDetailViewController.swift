//
//  BranchDetailViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class BranchDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // Outlet
    @IBOutlet weak var labelBranchName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var tableCurrentQ: UITableView!
    @IBOutlet weak var labelServiceTime: UILabel!
    
    // Variable
    var branchId: NSNumber = 0
    var branchName : String = ""
    var branchServiceTime : String = ""
    var branchTbTypeA : String = ""
    var branchTbTypeB : String = ""
    var branchTbTypeC : String = ""
    var branchTbTypeD : String = ""
    var restName : String = ""
    var locationName : String = ""
    
    var currentQA : NSNumber = 0
    var currentQB : NSNumber = 0
    var currentQC : NSNumber = 0
    var currentQD : NSNumber = 0
    var runningQA : NSNumber = 0
    var runningQB : NSNumber = 0
    var runningQC : NSNumber = 0
    var runningQD : NSNumber = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QueueController().displayCurrentQueue(branchId, uiView: self)
        CurrentRunningNoController().getCurrentRunningNoByBraId(branchId, uiView: self)
        
        print("------- Current QA : A\(self.currentQA)---------")
        print("------- Current QA : B\(self.currentQB)---------")
        print("------- Current QA : C\(self.currentQC)---------")
        print("------- Current QA : D\(self.currentQD)---------")
        

        print("------- Running QA : A\(self.runningQA)---------")
        print("------- Running QA : B\(self.runningQB)---------")
        print("------- Running QA : C\(self.runningQC)---------")
        print("------- Running QA : D\(self.runningQD)---------")
        
        
        self.title = restName
        //Set Backgroup color, Font Style for Navigation Bar
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)

        // Do any additional setup after loading the view.
        tableCurrentQ.allowsSelection = false
        tableCurrentQ.dataSource = self
        tableCurrentQ.delegate = self
        
        //Show Data
        labelBranchName.text = self.branchName
        labelLocation.text = self.locationName
        labelServiceTime.text = self.branchServiceTime
        
        
        let imageRestName = "\(self.restName)"+".jpg"
        let image = UIImage(named: imageRestName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 15, y: 80, width: 80, height: 70)
        view.addSubview(imageView)
        

        
    }
    
//    override func viewDidAppear(animated: Bool) {
//        labelBranchName.text = branchName
//        labelLocation.text = "GF, \(branchName)"
//        locationName = "GF, \(branchName)"
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CurrentQTableViewCell
        
        //Configure cell
        if(indexPath.row == 0){
            cell.labelTableType!.text = Constants.TableType.A as String + " " + branchTbTypeA
            cell.labelCurrentQ!.text = "\(Constants.TableType.A)\(currentQA.integerValue.format(Constants.DecimalFormat.Queue as String))"
            
            var diffA : NSNumber = 0
            diffA = runningQA.integerValue - currentQA.integerValue
            cell.labelNoOfWaiting!.text = diffA.stringValue
            
            
            print("Running A: \(runningQA.integerValue)")
            print("Current A: \(currentQA.integerValue)")
            print("DIFF A: \(diffA) (\(diffA.stringValue))")
            
        }
        else if (indexPath.row == 1){
            cell.labelTableType!.text = Constants.TableType.B as String + " " + branchTbTypeB
            cell.labelCurrentQ!.text = "\(Constants.TableType.B)\(currentQB.integerValue.format(Constants.DecimalFormat.Queue as String))"
            
            var diffB : NSNumber = 0
            diffB = runningQB.integerValue - currentQB.integerValue
            cell.labelNoOfWaiting!.text = diffB.stringValue
            
        }
        else if (indexPath.row == 2){
            cell.labelTableType!.text = Constants.TableType.C as String + " " + branchTbTypeC
            cell.labelCurrentQ!.text = "\(Constants.TableType.C)\(currentQC.integerValue.format(Constants.DecimalFormat.Queue as String))"
            
            var diffC : NSNumber = 0
            diffC = runningQC.integerValue - currentQC.integerValue
            cell.labelNoOfWaiting!.text = diffC.stringValue
            
        }
        else if (indexPath.row == 3){
            cell.labelTableType!.text = Constants.TableType.D as String + " " + branchTbTypeD
            cell.labelCurrentQ!.text = "\(Constants.TableType.D)\(currentQD.integerValue.format(Constants.DecimalFormat.Queue as String))"
            
            var diffD : NSNumber = 0
            diffD = runningQD.integerValue - currentQD.integerValue
            cell.labelNoOfWaiting!.text = diffD.stringValue
            
        }
        return cell
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        (segue.destinationViewController as! BookingViewController).restName = self.restName
        (segue.destinationViewController as! BookingViewController).branchId = self.branchId
        (segue.destinationViewController as! BookingViewController).branchName = self.branchName
        (segue.destinationViewController as! BookingViewController).locationName = self.locationName
        (segue.destinationViewController as! BookingViewController).serviceTime = self.branchServiceTime
    }


}
