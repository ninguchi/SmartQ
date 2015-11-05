// Ning

//

//  LogInViewController.swift

//  SmartQ

//

//  Created by ninguchi on 12/16/2557 BE.

//  Copyright (c) 2557 BlueSeed. All rights reserved.

//

// Test to commit file from Ning2 and P'May



import UIKit
import AVFoundation
import MessageUI

var audioPlayer = AVAudioPlayer()


class LogInViewController: UIViewController, CDTReplicatorDelegate {
    
    let instance = SingletonClass.shared
    let custController = CustomerController()
    let restController = RestaurantController()
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var buttonLogIn: UIButton!
    @IBOutlet weak var buttonSignUp: UIButton!
    @IBOutlet weak var buttonForgotPass: UIButton!
    
    @IBAction func backToLogin(segue: UIStoryboardSegue){
        print("Back To Login")
    }
    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.instance.pullItems()
        buttonLogIn.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInMethod(sender: AnyObject) {
        print("Press Login Button ")
        
        
//        var rest1 : Restaurant = Restaurant()
//        rest1.res_id = 1
//        rest1.res_name = "Fuji"
//        rest1.res_description = "Japanese Food"
//        rest1.res_noti_1 = 5
//        rest1.res_noti_2 = 3
//        rest1.res_noti_3 = 1
//        restController.createRestaurant(rest1)
//        
//        var rest2 : Restaurant = Restaurant()
//        rest2.res_id = 2
//        rest2.res_name = "Sizzler"
//        rest2.res_description = "Steak"
//        rest2.res_noti_1 = 5
//        rest2.res_noti_2 = 3
//        rest2.res_noti_3 = 1
//        restController.createRestaurant(rest2)
//        
//        var rest3 : Restaurant = Restaurant()
//        rest3.res_id = 3
//        rest3.res_name = "CoCo ICHIBANYA"
//        rest3.res_description = "Japanese Curry Rice"
//        rest3.res_noti_1 = 5
//        rest3.res_noti_2 = 3
//        rest3.res_noti_3 = 1
//        restController.createRestaurant(rest3)
//        
//        var rest4 : Restaurant = Restaurant()
//        rest4.res_id = 4
//        rest4.res_name = "OISHI"
//        rest4.res_description = "Japanese Buffet"
//        rest4.res_noti_1 = 5
//        rest4.res_noti_2 = 3
//        rest4.res_noti_3 = 1
//        restController.createRestaurant(rest4)
//        
//        var rest5 : Restaurant = Restaurant()
//        rest5.res_id = 5
//        rest5.res_name = "Sukishi"
//        rest5.res_description = "Japanese Buffet"
//        rest5.res_noti_1 = 5
//        rest5.res_noti_2 = 3
//        rest5.res_noti_3 = 1
//        restController.createRestaurant(rest5)
//        
//        var rest6 : Restaurant = Restaurant()
//        rest6.res_id = 6
//        rest6.res_name = "Yum Zaap"
//        rest6.res_description = "Thai Food"
//        rest6.res_noti_1 = 5
//        rest6.res_noti_2 = 3
//        rest6.res_noti_3 = 1
//        restController.createRestaurant(rest6)
//        
//        var rest7 : Restaurant = Restaurant()
//        rest7.res_id = 7
//        rest7.res_name = "MK"
//        rest7.res_description = "Suki"
//        rest7.res_noti_1 = 5
//        rest7.res_noti_2 = 3
//        rest7.res_noti_3 = 1
//        restController.createRestaurant(rest7)
        
        

//        var queue : Queue = Queue()
//        queue.que_id = 1
//        queue.que_type = 1
//        queue.que_bra_id = 1
//        queue.que_cus_id = 1
//        queue.que_status = 1
//        queue.que_tb_type = "A"
//        queue.que_no = 1
//        queue.que_no_person = 2
//        queue.que_child_flag = "N"
//        queue.que_wheel_flag = "N"
//        queue.que_confirm_code = 23059
//        queue.que_current_flag = "N"
//        queue.que_call_q_time = NSCalendar()
//        queue.que_complete_time = NSCalendar()
//        queue.que_reserve_time = NSCalendar()
//        queue.que_cancel_Time = NSCalendar()
//
//        QueueController().saveQueue(queue)
        
//        var test = NSMutableOrderedSet()
//        test.addObject(0)
//        test.addObject(2)
//        test.addObject(1)
//        test.addObject(5)
//        test.addObject(4)
//        test.addObject(3)
//        
//        print("BEFORE ------ \(test) -------")
//        
//        let sd = NSSortDescriptor(key: "", ascending: true)
//        
//        test.sortUsingDescriptors([sd])
//        
//        print("AFTER ------ \(test) -------")
        
//        var curObj : CurrentRunningNo = CurrentRunningNo()
//        curObj.cur_id = 6
//        curObj.cur_bra_id = 6
//        curObj.cur_ty_a = 0
//        curObj.cur_ty_b = 0
//        curObj.cur_ty_c = 0
//        curObj.cur_ty_d = 0
//        CurrentRunningNoController().createCurrentRunningNo(curObj)
//
        
        custController.authenMethod(txtUsername.text!, password: txtPassword.text!, uiView: self)
//
//        print("SOUND [BEGIN]")
        
//        var queueNo = "A25"
//        var soundName : String = ""
//        var delaytime : NSTimeInterval = 0.0
//        for character in queueNo {
//            print("Delay Time : \(delaytime)")
//            switch character {
//            case "A" :
//                soundName = "A"
//                delaytime = 3
//            case "B" :
//                soundName = "B"
//                delaytime = 3
//            case "C" :
//                soundName = "C"
//                delaytime = 3
//            case "D" :
//                soundName = "D"
//                delaytime = 3
//            case "0" :
//                soundName = "0"
//                delaytime = 1
//            case "1" :
//                soundName = "1"
//                delaytime = 1
//            case "2" :
//                soundName = "2"
//                delaytime = 1
//            case "3" :
//                soundName = "3"
//                delaytime = 1
//            case "4" :
//                soundName = "4"
//                delaytime = 1
//            case "5" :
//                soundName = "5"
//                delaytime = 1
//            case "6" :
//                soundName = "6"
//                delaytime = 1
//            case "7" :
//                soundName = "7"
//                delaytime = 1
//            case "8" :
//                soundName = "8"
//                delaytime = 1
//            case "9" :
//                soundName = "9"
//                delaytime = 1
//            default: print("end")
//            
//            }
//            
//            print("soundName : \(soundName)")
//            var soundURL = NSBundle.mainBundle().URLForResource(soundName, withExtension: "m4a")
//            audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
//            audioPlayer.play()
            
//            NSThread.sleepForTimeInterval(delaytime)
////            sleep(delaytime)
        
//        }
//            var endSoundURL = NSBundle.mainBundle().URLForResource("end", withExtension: "m4a")
//            audioPlayer = AVAudioPlayer(contentsOfURL: endSoundURL, error: nil)
//            audioPlayer.play()
//
        
        print("after authen method")
       
        
//        let mailComposeViewController = configuredMailComposeViewController()
//        if MFMailComposeViewController.canSendMail() {
//            print("Perform Sending...")
//            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
//            print("Send mail success")
//            
//        } else {
//            print("ERROR on sending mail")
//            self.showSendMailErrorAlert()
//        }
        
//        http://www.andrewcbancroft.com/2014/08/25/send-email-in-app-using-mfmailcomposeviewcontroller-with-swift/
//        http://www.appcoda.com/ios-programming-101-send-email-iphone-app/
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
//    func configuredMailComposeViewController() -> MFMailComposeViewController {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
//        
//        mailComposerVC.setToRecipients(["p.joyjung@gmail.com"])
//        mailComposerVC.setSubject("Sending you an in-app e-mail...")
//        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
//        
//        
//        return mailComposerVC
//    }
//    
//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
//    }
//    
//    // MARK: MFMailComposeViewControllerDelegate Method
//    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
//        controller.dismissViewControllerAnimated(true, completion: nil)
//    }
//    
//    
    /*
    
    // MARK: - Navigation
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    // Get the new view controller using segue.destinationViewController.
    
    // Pass the selected object to the new view controller.
    
    }
    
    */
    
    
    
    
}

