//
//  BookingViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    @IBOutlet weak var labelServiceTime: UILabel!
    @IBOutlet weak var labelBranchName: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var switchChildren: UISwitch!
    @IBOutlet weak var switchWheelchair: UISwitch!
    
    @IBOutlet weak var labelNumber: UILabel!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var stepperNumber: UIStepper!
    
    var childrenFlag:Bool = false
    var wheelchairFlag:Bool = false
    
    var restName : String = ""
    var branchObj : Branch = Branch()
    var branchId : NSNumber = 0
    var branchName : String = ""
    var locationName : String = ""
    var serviceTime : String = ""
    var currentRunningNo : CurrentRunningNo = CurrentRunningNo()
    var queue : Queue = Queue()
    
    @IBAction func switchChildMethod(sender: AnyObject) {
        if switchChildren.on {
            childrenFlag = true
        }
        else {
            childrenFlag = false
        }
    }
    
    @IBAction func switchWheelMethod(sender: AnyObject) {
        if switchWheelchair.on {
            wheelchairFlag = true
        }
        else {
            wheelchairFlag = false
        }
    }

    @IBAction func stepNumber(sender: UIStepper) {
        labelNumber.text = Int(sender.value).description
    }
    
    @IBAction func confirmBookingMethod(sender: AnyObject) {
        print("PRESS Confirm Button")
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let currentCustId:NSNumber = prefs.integerForKey("CURRENTCUSTID") as NSNumber
        
        let myString : String = self.labelNumber.text!
        let person: Int? = Int(myString)
        
        if (person != nil) {
            
            CurrentRunningNoController().getCurrentRunningNoByBraId(self.branchId, uiView: self)
            sleep(1)
            BranchController().getBranchById(self.branchId, uiView: self)
            sleep(1)
            QueueController().createQueue(self.branchId, noOfPerson: person!, childFlag: childrenFlag, wheelchairFlag: wheelchairFlag, currentCustId: currentCustId, branch: branchObj, crnObj: currentRunningNo, uiView: self)

        }
//

//
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = restName

        //Set color, font style on Navigation Bar
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        
        //Set button to circle
        buttonConfirm.layer.cornerRadius = 5
        
        labelBranchName.text = branchName
        labelLocation.text = locationName
        labelServiceTime.text = serviceTime
        
        
        let imageRestName = "\(restName)"+".jpg"
        let image = UIImage(named: imageRestName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 15, y: 80, width: 80, height: 70)
        view.addSubview(imageView)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        (segue.destinationViewController as! ConfirmBookingViewController).restName = self.restName
        (segue.destinationViewController as! ConfirmBookingViewController).branchName = self.branchName
        (segue.destinationViewController as! ConfirmBookingViewController).locationName = self.locationName
        (segue.destinationViewController as! ConfirmBookingViewController).branchObj = self.branchObj
        (segue.destinationViewController as! ConfirmBookingViewController).queueObj = self.queue
        (segue.destinationViewController as! ConfirmBookingViewController).numberPerson = self.labelNumber.text!
        (segue.destinationViewController as! ConfirmBookingViewController).serviceTime = self.labelServiceTime.text!
        (segue.destinationViewController as! ConfirmBookingViewController).sourceSegue = Constants.SourceSegue.BookingViewController as! String
    }
    

}
