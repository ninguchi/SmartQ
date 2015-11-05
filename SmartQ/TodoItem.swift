//
//  TodoItem.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 1/28/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

@objc public class TodoItem: NSObject, CDTDataObject{
    var name : NSString = ""
    var priority : NSNumber = 0
    
    public var metadata : CDTDataObjectMetadata?
    
}
