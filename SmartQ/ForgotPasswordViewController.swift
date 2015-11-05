//
//  ForgotPasswordViewController.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 12/26/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        buttonBack.layer.cornerRadius = 5
        buttonConfirm.layer.cornerRadius = 5
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
    
    @IBAction func forgotPassMethod(sender: AnyObject) {
        
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
