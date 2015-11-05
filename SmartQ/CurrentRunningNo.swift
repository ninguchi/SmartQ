//  CurrentRunningNo.swift

//  SmartQ

//

//  Created by Worayut Traiworadecha on 2/6/2558 BE.

//  Copyright (c) 2558 BlueSeed. All rights reserved.

//

@objc public class CurrentRunningNo : NSObject, CDTDataObject{
    
    
    
    var cur_id : NSNumber = 0
    
//    var cur_branch : Branch = Branch()
    
    var cur_bra_id : NSNumber = 0
    var cur_ty_a : NSNumber = 0
    var cur_ty_b : NSNumber = 0
    var cur_ty_c : NSNumber = 0
    var cur_ty_d : NSNumber = 0
    
    public var metadata:CDTDataObjectMetadata?
    
    
    
}