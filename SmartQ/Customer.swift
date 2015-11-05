//
//  UserStaff.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 1/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

@objc public class Customer: NSObject, CDTDataObject {
    
    var cus_id : NSNumber = 0
    var cus_firstname : NSString = ""
    var cus_lastname : NSString = ""
    var cus_email : NSString = ""
    var cus_mobile_no : NSString = ""
    var cus_password : NSString = ""
    var cus_dob : NSDate = NSDate()
    
    public var metadata:CDTDataObjectMetadata?
    
}
