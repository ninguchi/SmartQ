//
//  ShoppingMall.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//
@objc public class ShoppingMall : NSObject, CDTDataObject{
    
    var sho_id : NSNumber = 0
    var sho_name : NSString  = ""
    var sho_latitude : Double = 0.0
    var sho_longitude : Double = 0.0
    var sho_distance : Double = 0.0
    public var metadata:CDTDataObjectMetadata?

    
}