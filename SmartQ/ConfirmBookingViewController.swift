//
//  ConfirmBookingViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class ConfirmBookingViewController: UIViewController {

    @IBOutlet weak var labelQueueNo: UILabel!
    
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelEstimateTime: UILabel!
    @IBOutlet weak var labelRemainQueue: UILabel!
    @IBOutlet weak var buttonDone: UIButton!
    
    @IBOutlet weak var labelNumberPerson: UILabel!
    
    @IBOutlet weak var labelBranchName: UILabel!
    @IBOutlet weak var labelConfirmCode: UILabel!
    
    @IBOutlet weak var labelServiceTime: UILabel!
    
    var restName : String = ""
    var branchName : String = ""
    var locationName : String = ""
    var numberPerson : String = ""
    var serviceTime : String = ""
    var branchObj : Branch = Branch()
    var queueObj : Queue = Queue()
    
    var currentQA : NSNumber = 0
    var currentQB : NSNumber = 0
    var currentQC : NSNumber = 0
    var currentQD : NSNumber = 0
    var sourceSegue : String = ""
    
    
    @IBAction func completeBookingMethod(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Remain Queue (By get the current queue (Flag == "Y")
        QueueController().getCurrentQueue(branchObj.bra_id, tb_type: queueObj.que_tb_type, uiView: self)
        
        
        var nav = self.navigationController?.navigationBar
        print("------------- Source Segue : \(sourceSegue) ---------------------")
        if(sourceSegue == Constants.SourceSegue.BookingViewController){
            self.navigationItem.hidesBackButton = true
            buttonDone.hidden = false
            buttonDone.layer.cornerRadius = 5
        }else{
            self.navigationItem.hidesBackButton = false
            buttonDone.hidden = true
            buttonDone.layer.cornerRadius = 5
        }
        
        
        nav?.barTintColor = UIColor(red: (254/255.0), green: (160/255.0), blue: (4/255.0), alpha: 1.0)
        nav?.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 20)!, NSForegroundColorAttributeName: UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)]
        nav?.tintColor = UIColor(red: (36/255.0), green: (17/255.0), blue: (0/255.0), alpha: 1.0)
        
        
        
        
        // Do any additional setup after loading the view.
//        labelRestName.text = restName
        labelBranchName.text = branchName
        labelLocation.text = locationName
        labelServiceTime.text = serviceTime
        labelNumberPerson.text = "\(self.queueObj.que_no_person)"
        labelQueueNo.text = "\(self.queueObj.que_tb_type)\(self.queueObj.que_no.integerValue.format(Constants.DecimalFormat.Queue as String))"
        labelConfirmCode.text = "\(self.queueObj.que_confirm_code)"
        
        
        QueueController().calculateRemainQAndWaitingTime(self)
        
        let imageRestName = "\(restName)"+".jpg"
        let image = UIImage(named: imageRestName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 15, y: 80, width: 80, height: 70)
        view.addSubview(imageView)
        
        
        //
//        var remainQ : Int = 0
//        var estTime : Int = 0
//        if(queueObj.que_tb_type == Constants.TableType.A){
//            print("Current Queue No: [A\(currentQA)]")
//            
//            
//            remainQ = queueObj.que_no.integerValue - currentQA.integerValue
//            estTime = remainQ * branchObj.bra_ty_a_turnover.integerValue
//            
//            print("Remaining Q: \(remainQ) Que")
//            print("Estimate Time: \(estTime) Min")
//            
//        }else if(queueObj.que_tb_type == Constants.TableType.B){
//            print("Current Queue No: [A\(currentQB)]")
//            
//            remainQ = queueObj.que_no.integerValue - currentQB.integerValue
//            estTime = remainQ * branchObj.bra_ty_b_turnover.integerValue
//            
//            print("Remaining Q: \(remainQ) Que")
//            print("Estimate Time: \(estTime) Min")
//            
//        }else if(queueObj.que_tb_type == Constants.TableType.C){
//            print("Current Queue No: [A\(currentQC)]")
//            
//            remainQ = queueObj.que_no.integerValue - currentQC.integerValue
//            estTime = remainQ * branchObj.bra_ty_c_turnover.integerValue
//            
//            print("Remaining Q: \(remainQ) Que")
//            print("Estimate Time: \(estTime) Min")
//            
//        }else if(queueObj.que_tb_type == Constants.TableType.D){
//            print("Current Queue No: [A\(currentQD)]")
//            
//            remainQ = queueObj.que_no.integerValue - currentQD.integerValue
//            estTime = remainQ * branchObj.bra_ty_d_turnover.integerValue
//        
//            print("Remaining Q: \(remainQ) Que")
//            print("Estimate Time: \(estTime) Min")
//            
//        }
//        
//        labelRemainQueue.text = "\(remainQ)"
//        labelEstimateTime.text = "\(estTime)"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneMethod(sender: AnyObject) {
        self.tabBarController?.selectedIndex = 2
        print("HERE")
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
