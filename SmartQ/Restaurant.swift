//
//  Restaurant.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

@objc public class Restaurant: NSObject, CDTDataObject {
    var res_id : NSNumber = 0
    var res_name: NSString = ""
    var res_description : NSString = ""
    var res_noti_1 : NSNumber = 0
    var res_noti_2 : NSNumber = 0
    var res_noti_3 : NSNumber = 0
    
    public var metadata:CDTDataObjectMetadata?
    
}