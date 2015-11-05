//
//  RegistrationViewController.swift
//  SmartQ
//
//  Created by ninguchi on 12/16/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFirstname: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    var createResult : Bool = false
    var duplicateUser : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonBack.layer.cornerRadius = 5
        buttonSignUp.layer.cornerRadius = 5
    }
    /*
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpMethod(sender: AnyObject) {
        
        //Check Duplicate User
        CustomerController().checkDuplicateMethod(txtEmail.text!, uiView: self)
        sleep(1)
        
        //Validate Requiredd Field
        var validateRequired = true
        if(txtEmail.text == ""){
            validateRequired = false
        }
        
        if(txtFirstname.text == ""){
            validateRequired = false
        }
        
        if(txtLastname.text == ""){
            validateRequired = false
        }
        
        if(txtMobileNo.text == ""){
            validateRequired = false
        }
        
        if(txtPassword.text == ""){
            validateRequired = false
        }
        
        if(txtConfirmPassword.text == ""){
            validateRequired = false
        }
        
        if(validateRequired){
            //Pass
            if(self.duplicateUser){
                //Not allow to create
                let alertPassword = UIAlertView()
                alertPassword.title = "Registration Error"
                alertPassword.message = "Email is already existed"
                alertPassword.addButtonWithTitle("OK")
                alertPassword.show()
                
            }else{
                //OK
                //Check password vs confirm password
                if(txtPassword.text == txtConfirmPassword.text){
                    
                    CustomerController().createCustomer(txtEmail.text!, firstname: txtFirstname.text!, lastname: txtLastname.text!, mobilePhone: txtMobileNo.text!, password: txtPassword.text!, uiView: self)
                    
                    if(self.createResult){
                        //Display success
                        let alertCreateSuccess = UIAlertView()
                        alertCreateSuccess.title = "Registration Success"
                        alertCreateSuccess.message = "Your account has been created successfully"
                        alertCreateSuccess.addButtonWithTitle("OK")
                        alertCreateSuccess.show()
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    
                }else{
                    //Display popup
                    let alertPassword = UIAlertView()
                    alertPassword.title = "Registration Error"
                    alertPassword.message = "Please verify your password"
                    alertPassword.addButtonWithTitle("OK")
                    alertPassword.show()
                    
                }
                
            }

        }else{
            //Display popup
            let alertPassword = UIAlertView()
            alertPassword.title = "Registration Error"
            alertPassword.message = "Please enter the required fields"
            alertPassword.addButtonWithTitle("OK")
            alertPassword.show()
            
        }
        
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
