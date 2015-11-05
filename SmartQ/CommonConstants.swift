//
//  CommonConstants.swift
//  SmartQRes
//
//  Created by ninguchi on 3/8/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import Foundation

struct Constants {
    struct AdminType {
        static let Restaurant:NSNumber = 1
        static let Branch:NSNumber = 2
    }
    struct QueueType {
        static let Client:NSNumber = 1
        static let Front:NSNumber = 2
    }
    struct QueueStatus {
        static let Waiting:NSNumber = 1
        static let Completed:NSNumber = 2
        static let NoShow:NSNumber = 3
        static let Cancelled:NSNumber = 4
    }
    struct QueueStatusName {
        static let WaitingStatus:String = "Waiting"
        static let CompletedStatus:NSString = "Completed"
        static let NoShowStatus:NSString = "No Show"
        
    }
    struct TableType {
        static let A:NSString = "A"
        static let B:NSString = "B"
        static let C:NSString = "C"
        static let D:NSString = "D"
    }
    
    struct  Flag {
        static let YES:NSString = "Y"
        static let NO:NSString = "N"
    }
    struct  DecimalFormat {
        static let Queue:NSString = "02"
    }
    struct  SourceSegue {
        static let BookingViewController:NSString = "BookingViewController"
        static let MyQueueController:NSString = "MyQueueController"
    }
}

extension Int {
    func format(f: String) -> String {
        return NSString(format: "%\(f)d", self) as! String
    }
}
