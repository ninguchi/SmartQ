//  Queue.swift

//  SmartQ

//

//  Created by Worayut Traiworadecha on 2/3/2558 BE.

//  Copyright (c) 2558 BlueSeed. All rights reserved.

//

@objc public class Queue: NSObject, CDTDataObject {
    
    
    
    var que_id : NSNumber =  0
    var que_type : NSNumber = 0
    var que_bra_id : NSNumber = 0
    var que_cus_id : NSNumber = 0
    var que_res_name_display : NSString = ""
    var que_bra_name_display : NSString = ""
    
//    var que_branch : Branch = Branch()

//    var que_customer : Customer = Customer()
    
    var que_status : NSNumber = 0
    var que_tb_type : NSString = ""
    var que_no : NSNumber = 0
    var que_no_person : NSNumber = 0
    var que_child_flag : NSString = ""
    var que_wheel_flag : NSString = ""
    var que_confirm_code : NSNumber = 0
    var que_current_flag : NSString = ""
    var que_call_q_time : NSDate = NSDate()
    var que_complete_time : NSDate = NSDate()
    var que_reserve_time : NSDate = NSDate()
    var que_cancel_time : NSDate = NSDate()
    
    public var metadata:CDTDataObjectMetadata?
    
    
    
}