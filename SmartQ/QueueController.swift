//  QueueController.swift
//  SmartQ
//  Created by Worayut Traiworadecha on 2/3/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.

import Foundation

class QueueController {
    
    var queueList : [Queue] = []
    var queryPredicate:NSPredicate!
    var instance = SingletonClass.shared
    let datastore: CDTStore!
    
    init(){
        
        self.datastore = instance.connectionSmartQDB()
        self.datastore.mapper.setDataType("Queue", forClassName: NSStringFromClass(Queue.classForCoder()))
        self.datastore.createIndexWithName("QueueIndex", fields: ["que_bra_id", "que_tb_type", "que_current_flag", "que_cus_id", "que_status"], completionHandler: { (error:NSError!) -> Void in
            //an error is set if index creation failed.
            print("ERROR --> \(error)")
        })
        
    }
    
    func displayCurrentQueue(bra_id: NSNumber, uiView: BranchDetailViewController){
        print("QUEUE CONTROLLER [displayCurrentQueue]")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        //getCurrentQueue for bra_id
        self.getCurrentQueue(bra_id, tb_type: Constants.TableType.A as String, uiView: uiView)
        self.getCurrentQueue(bra_id, tb_type: Constants.TableType.B as String, uiView: uiView)
        self.getCurrentQueue(bra_id, tb_type: Constants.TableType.C as String, uiView: uiView)
        self.getCurrentQueue(bra_id, tb_type: Constants.TableType.D as String, uiView: uiView)
        
        uiView.tableCurrentQ.reloadData()
    
    }
    
    
    
    func createQueue(var bra_id : NSNumber,
        var noOfPerson: NSNumber, var childFlag: Bool, var wheelchairFlag: Bool, var currentCustId : NSNumber,
        var branch: Branch, var crnObj: CurrentRunningNo, uiView: BookingViewController){
            
            var queue = Queue()
            
            print("BRANCH ID: \(bra_id)")
            print("NO. Of Person   : \(noOfPerson)")
            print("Child Flag      : \(childFlag)")
            print("Wheelchair Flag : \(wheelchairFlag)")
            print("Current Cust    : \(currentCustId)")
            
            print("A RUNNING Result \(crnObj.cur_ty_a)")
            print("B RUNNING Result \(crnObj.cur_ty_b)")
            print("C RUNNING Result \(crnObj.cur_ty_c)")
            print("D RUNNING Result \(crnObj.cur_ty_d)")
            
            print("Branch Name :  \(branch.bra_name) --------- ")
            
            //Get Maximum ID
            //self.instance.pullReplicator.delegate = uiView
            //NSThread.sleepForTimeInterval(0.5)
            self.instance.pullItems()
            
            var query : CDTQuery
            query = CDTCloudantQuery(dataType: "Queue")
            datastore.performQuery(query, completionHandler: {(results, error) -> Void in
                if((error) != nil){
                    print("ERROR --> \(error) ")
                    queue.que_id = 1
                }
                else{
                    self.queueList = results as! [Queue]
                    
                    
                    if(self.queueList.count == 0){
                        queue.que_id = 1
                    }else{
                        var os = NSMutableOrderedSet()
                        os.addObjectsFromArray(self.queueList)
                        let sd = NSSortDescriptor(key: "que_id", ascending: true)
                        os.sortUsingDescriptors([sd])
                        self.queueList = os.array as! [Queue]
                    
                        var temp : Queue = Queue()
                        temp = self.queueList[self.queueList.count-1]
                        queue.que_id = temp.que_id.integerValue + 1
                    }
                }
            })
            
            NSThread.sleepForTimeInterval(0.5)
            
            var queueNo : NSNumber = 0
            if (noOfPerson.integerValue >= branch.bra_ty_a_min.integerValue && noOfPerson.integerValue <= branch.bra_ty_a_max.integerValue) {
                
                //A Type
                queue.que_tb_type = Constants.TableType.A
                
                //Update current running no into table
                queueNo = crnObj.cur_ty_a.integerValue + 1
                crnObj.cur_ty_a = queueNo
                CurrentRunningNoController().updateCurrentRunningNo(crnObj)
                
            }else if(noOfPerson.integerValue >= branch.bra_ty_b_min.integerValue && noOfPerson.integerValue <= branch.bra_ty_b_max.integerValue){
                
                //B Type
                queue.que_tb_type = Constants.TableType.B
                
                //Update current running no into table
                queueNo = crnObj.cur_ty_b.integerValue + 1
                crnObj.cur_ty_b = queueNo
                CurrentRunningNoController().updateCurrentRunningNo(crnObj)
                
            }else if(noOfPerson.integerValue >= branch.bra_ty_c_min.integerValue && noOfPerson.integerValue <= branch.bra_ty_c_max.integerValue){
                
                //C Type
                queue.que_tb_type = Constants.TableType.C
                
                //Update current running no into table
                queueNo = crnObj.cur_ty_c.integerValue + 1
                crnObj.cur_ty_c = queueNo
                CurrentRunningNoController().updateCurrentRunningNo(crnObj)
                
            }else if(noOfPerson.integerValue >= branch.bra_ty_d_min.integerValue && noOfPerson.integerValue <= branch.bra_ty_d_max.integerValue){
                
                //D Type
                queue.que_tb_type = Constants.TableType.D
             
                //Update current running no into table
                queueNo = crnObj.cur_ty_d.integerValue + 1
                crnObj.cur_ty_d = queueNo
                CurrentRunningNoController().updateCurrentRunningNo(crnObj)
                
            }
            
            print("Get the queue no : \(queue.que_tb_type) \(queueNo)")
            
            //Set Queue Attribute
            queue.que_type = Constants.QueueType.Client //Default performed by customer
            queue.que_bra_id = branch.bra_id
            queue.que_bra_name_display = branch.bra_name
            queue.que_res_name_display = branch.bra_res_name
            queue.que_cus_id = currentCustId
            queue.que_status = Constants.QueueStatus.Waiting
            queue.que_no = queueNo
            queue.que_no_person = noOfPerson
            if(childFlag){
                queue.que_child_flag = Constants.Flag.YES
            }else{
                queue.que_child_flag = Constants.Flag.NO
            }
            
            if(wheelchairFlag){
                queue.que_wheel_flag = Constants.Flag.YES
            }else{
                queue.que_wheel_flag = Constants.Flag.NO
            }
            
            
            print("----- QUEUE ID: \(queue.que_id) ------ ")
            
//            queue.que_id = 20
            queue.que_confirm_code = self.randomInt(100000, max: 999999)
            queue.que_current_flag = Constants.Flag.NO
            queue.que_reserve_time = NSDate()
            
            datastore.save(queue, completionHandler: { (object, error) -> Void in
                if(error != nil){
                    print("Error on save queue \(error)")
                    
                } else {
                    queue = object as! Queue
                    print("Save Queue Successfully")
                    
                }
            })
            
            self.instance.pushItems()
            
            uiView.queue = queue
            
    }
    
    func calculateRemainQAndWaitingTime(uiView: ConfirmBookingViewController) -> Void{
        print("QUEUE Controller [calculateRemainQAndWaitingTime] ")
        self.instance.pullItems()
        NSThread.sleepForTimeInterval(0.5)
        var remainQ : Int = 0
        var estTime : Int = 0
        
        
        if(uiView.queueObj.que_tb_type == Constants.TableType.A){
            print("Current Queue No: [A\(uiView.currentQA)]")
            
            
            remainQ = uiView.queueObj.que_no.integerValue - uiView.currentQA.integerValue - 1
            estTime = (remainQ + 1) * uiView.branchObj.bra_ty_a_turnover.integerValue
            
            print("Remaining Q: \(remainQ) Que")
            print("Estimate Time: \(estTime) Min")
            
        }else if(uiView.queueObj.que_tb_type == Constants.TableType.B){
            print("Current Queue No: [A\(uiView.currentQB)]")
            
            remainQ = uiView.queueObj.que_no.integerValue - uiView.currentQB.integerValue - 1
            estTime = (remainQ + 1) * uiView.branchObj.bra_ty_b_turnover.integerValue
            
            print("Remaining Q: \(remainQ) Que")
            print("Estimate Time: \(estTime) Min")
            
        }else if(uiView.queueObj.que_tb_type == Constants.TableType.C){
            print("Current Queue No: [A\(uiView.currentQC)]")
            
            remainQ = uiView.queueObj.que_no.integerValue - uiView.currentQC.integerValue - 1
            estTime = (remainQ + 1) * uiView.branchObj.bra_ty_c_turnover.integerValue
            
            print("Remaining Q: \(remainQ) Que")
            print("Estimate Time: \(estTime) Min")
            
        }else if(uiView.queueObj.que_tb_type == Constants.TableType.D){
            print("Current Queue No: [A\(uiView.currentQD)]")
            
            remainQ = uiView.queueObj.que_no.integerValue - uiView.currentQD.integerValue - 1
            estTime = (remainQ + 1) * uiView.branchObj.bra_ty_d_turnover.integerValue
            
            print("Remaining Q: \(remainQ) Que")
            print("Estimate Time: \(estTime) Min")
            
        }
        
        if(remainQ < 0){
            //Call A2 and A
            uiView.labelRemainQueue.text = "0"
            uiView.labelEstimateTime.text = "0"
            
        }else{
            uiView.labelRemainQueue.text = "\(remainQ)"
            uiView.labelEstimateTime.text = "\(estTime)"
        }
        
    }

    
//    func callNextQueue(var datastore: CDTStore!, branch: Branch, tb_type: String) -> Queue {
//        
//        //Get Current Queue in table Queue and set current flag to be "N"
//        var currentQueue = self.getCurrentQueue(branch.bra_id.integerValue, tb_type: tb_type)
//        currentQueue.que_current_flag = "N" //Update current flag == "N"
//        currentQueue = self.saveQueue(currentQueue)
//        
//        //Get the next que (que_no +1)
//        var nextQueueNo = currentQueue.que_no.integerValue + 1
//        var nextQueue = Queue()
//        nextQueue = self.getQueueByQueueNo(branch.bra_id.integerValue, tb_type: tb_type, que_no: nextQueueNo)
//        nextQueue.que_current_flag = "Y"    //Update current flag == "Y"
//        nextQueue = self.saveQueue(nextQueue)
//        
//        //Display the next queue no
//        print("The current queue no is \(tb_type) \(currentQueue.que_no)")
//        print("The next queue no is    \(tb_type) \(nextQueue.que_no)")
//        
//        
//        return nextQueue
//        
//    }
    
    func getQueueMaxId() -> NSNumber{
        print("QUEUE CONTROLLER [getQueueMaxId] ")
        
        self.instance.pullItems()
        
        var maxId : NSNumber = 0
        var query : CDTQuery
        query = CDTCloudantQuery(dataType: "Queue")
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("ERROR --> \(error) ")
            }
            else{
                self.queueList = results as! [Queue]
                
                var os = NSMutableOrderedSet()
                os.addObjectsFromArray(self.queueList)
                let sd = NSSortDescriptor(key: "que_id", ascending: true)
                os.sortUsingDescriptors([sd])
                self.queueList = os.array as! [Queue]
                
                var temp : Queue = Queue()
                temp = self.queueList[self.queueList.count-1]
                maxId = temp.que_id
                
            }
        })

        return maxId
        
        
    }
    
    
    func getCurrentQueue(var bra_id: NSNumber, var tb_type : String, uiView: BranchDetailViewController) {
        print("QUEUE CONTROLLER [getCurrentQueue] tableType: \(tb_type)")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var queue = Queue()
        var query : CDTQuery
        
        self.queryPredicate = NSPredicate(format: "(que_bra_id = %@ AND que_tb_type = %@ AND que_current_flag = 'Y')", bra_id , tb_type)
        query = CDTCloudantQuery(dataType: "Queue", withPredicate: self.queryPredicate)
        self.datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
                
            }
            else{
                if(results.count != 1 ){
                    print("----- Not Found Current Queue ----")
                    if(tb_type == Constants.TableType.A){
                        uiView.currentQA = 0
                    }else if(tb_type == Constants.TableType.B){
                        uiView.currentQB = 0
                    }else if(tb_type == Constants.TableType.C){
                        uiView.currentQC = 0
                    }else if(tb_type == Constants.TableType.D){
                        uiView.currentQD = 0
                    }
                    
                }else{
                    queue = results[0] as! Queue
                    print("------ Found Queue \(queue.que_tb_type)\(queue.que_no) ----")
                    if(tb_type == Constants.TableType.A){
                        uiView.currentQA = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.B){
                        uiView.currentQB = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.C){
                        uiView.currentQC = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.D){
                        uiView.currentQD = queue.que_no
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    
    func getCurrentQueue(var bra_id: NSNumber, var tb_type : NSString, uiView: ConfirmBookingViewController) {
        print("QUEUE CONTROLLER [getCurrentQueue] tableType: \(tb_type)")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var queue = Queue()
        var query : CDTQuery
        
        self.queryPredicate = NSPredicate(format: "(que_bra_id = %@ AND que_tb_type = %@ AND que_current_flag = 'Y')", bra_id , tb_type)
        query = CDTCloudantQuery(dataType: "Queue", withPredicate: self.queryPredicate)
        self.datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
                
            }
            else{
                if(results.count != 1 ){
                    print("----- Not Found Current Queue ----")
                    if(tb_type == Constants.TableType.A){
                        uiView.currentQA = 0
                    }else if(tb_type == Constants.TableType.B){
                        uiView.currentQB = 0
                    }else if(tb_type == Constants.TableType.C){
                        uiView.currentQC = 0
                    }else if(tb_type == Constants.TableType.D){
                        uiView.currentQD = 0
                    }
                    
                }else{
                    queue = results[0] as! Queue
                    print("------ Found Queue \(queue.que_tb_type)\(queue.que_no) ----")
                    if(tb_type == Constants.TableType.A){
                        uiView.currentQA = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.B){
                        uiView.currentQB = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.C){
                        uiView.currentQC = queue.que_no
                        
                    }else if(tb_type == Constants.TableType.D){
                        uiView.currentQD = queue.que_no
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    
    
    func getQueueByQueueNo(var bra_id: Int, var tb_type: String, var que_no: Int) -> Queue{
        var queue = Queue()
        var query : CDTQuery
        
        self.queryPredicate = NSPredicate(format: "(que_bra_id = %@ AND que_tb_type = %@ AND que_no = %@)", bra_id , tb_type, que_no)
        query = CDTCloudantQuery(dataType: "Queue", withPredicate: self.queryPredicate)
        self.datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print(error)
                
            }
            else{
                if(results.count != 1 ){
                    //Error --> Get more than 1 que result
                    print("Error on get more than 1  queue result for queueNo: [\(que_no)] bra_id: [\(bra_id)] and table type [\(tb_type)]")
                    
                }else{
                    queue = results[0] as! Queue
                    
                }
                
            }
            
        })
        
        
        //Get the current queue for branch
        return queue

        
    }
    
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    
    func getQueueByCusIdAndStatusId(cusId: NSNumber, statusId: NSNumber, uiView: MyQueueTableViewController) -> Void {
        print("QUEUE CONTROLLER [getQueueByCusIdAndStatusId] ")
        
        //self.instance.pullReplicator.delegate = uiView
        //NSThread.sleepForTimeInterval(0.5)
        self.instance.pullItems()
        
        var query : CDTQuery
        self.queryPredicate = NSPredicate(format: "(que_cus_id = %@ AND que_status = %@)", cusId, statusId)
        query = CDTCloudantQuery(dataType: "Queue", withPredicate: self.queryPredicate)
        datastore.performQuery(query, completionHandler: {(results, error) -> Void in
            if((error) != nil){
                print("Error on query queue by que_cus_ids \(error) ")
            }else{
                print("Found \(results.count) Queue for cus_id = \(cusId) , status \(statusId) ")
                if(results.count > 0){
                    var tempList = results as! [Queue]
                    
                    var os = NSMutableOrderedSet()
                    os.addObjectsFromArray(tempList)
                    let sd = NSSortDescriptor(key: "que_id", ascending: false)
                    os.sortUsingDescriptors([sd])
                    tempList = os.array as! [Queue]

                    for i in 0..<tempList.count {
                        print("---- 1. \(i)----")
                        var tempQue = results[i] as! Queue
                        uiView.queueList.append(tempQue)
                        
                    }
                }
                uiView.tableView.reloadData()
            }
        })
        print("APPEND ==> \(uiView.queueList.count)")
        
    }
    
    func cancelQueue(queId: NSNumber, uiView: MyQueueTableViewController){
        
        
        
    }
    
    func updateQueueStatus(queue: Queue, uiView: MyQueueTableViewController) -> Void {
        print("QUEUE CONTROLLER [updateQueueStatus] ")
        datastore.save(queue, completionHandler: { (object, error) -> Void in
            
            if(error != nil){
                //self.logger.logErrorWithMessages("createItem failed with error \(error.description)")
                print("Error on update queue status \(error)")
                
            } else {
                var tempQ = object as! Queue
                print("Update Queue Status Successfully : [id: \(tempQ.que_id)] \(tempQ.que_tb_type)\(tempQ.que_no) : \(tempQ.que_status)")
                
            }
        })
        self.instance.pushItems()
        
    }
    
}

