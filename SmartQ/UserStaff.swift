//
//  UserStaff.swift
//  SmartQRes
//
//  Created by Kamnung Pitukkorn on 1/9/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

@objc public class UserStaff: NSObject, CDTDataObject {
    
    var uss_id : NSNumber = 0
    var uss_res_id : NSNumber = 0
    var uss_bra_id : NSNumber = 0
    var uss_type : NSNumber = 0
    var uss_username : NSString = ""
    var uss_password : NSString = ""
    public var metadata:CDTDataObjectMetadata?
}
