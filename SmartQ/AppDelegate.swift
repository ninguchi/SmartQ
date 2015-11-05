//
//  AppDelegate.swift
//  SmartQ
//
//  Created by ninguchi on 12/14/2557 BE.
//  Copyright (c) 2557 BlueSeed. All rights reserved.
//

import UIKit
import CoreData

let IBM_SYNC_ENABLE = true

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return GPPURLHandler.handleURL(url, sourceApplication: sourceApplication, annotation: annotation) || FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication)
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        
        //newCode
        var applicationId = ""
        var applicationSecret = ""
        var applicationRoute  = ""
        
        var hasValidConfiguration = true
        var exception:NSException?
        var errorMessage = ""
        
        //for debuging different authentication methods, this clears the backend oauth token, if a token is found then it's used
        //clearKeychain()
        
        // Read the applicationId from the smartqlist.plist.
        var configurationPath = NSBundle.mainBundle().pathForResource("smartqlist", ofType: "plist")
        
        if(configurationPath != nil){
            if let configuration = NSDictionary(contentsOfFile: configurationPath!){
                applicationId = configuration["applicationId"] as! String
                print("applicationId " + applicationId)
                if(applicationId == ""){
                    hasValidConfiguration = false
                    errorMessage = "Open the smartqlist.plist and set the applicationId to the BlueMix applicationId"
                }
                applicationRoute = configuration["applicationRoute"] as! String
                if(applicationRoute == ""){
                    hasValidConfiguration = false
                    errorMessage = "Open the smartqlist.plist and set the applicationRoute to the BlueMix application's route"
                }
                
                print("----------------------1 CONFIGURATION PASSED --------------------- ")
            } else {
                hasValidConfiguration = false
                errorMessage = "Problems parsing applicationId or applicationRoute from local file smartqlist.plist"
                print("----------------------2 CONFIGURATION FAILED --------------------- ")
            }
        } else {
            hasValidConfiguration = false
            errorMessage = "Problems reading path for file smartqlist.plist"
            print("----------------------3 CONFIGURATION FAILED --------------------- ")
        }
        
        
        if(hasValidConfiguration){
            print("Intializing SDK")
            IMFClient.sharedInstance().initializeWithBackendRoute(applicationRoute, backendGUID: applicationId)
            /*Authentication is required to connect to backend services,
            For this sample App register all 3 handler are register locally but only 1 will be use
            depending how the client was register in AMS (Advance Mobile Access)
            */
            print("Setting facebook authentication handler")
            IMFFacebookAuthenticationHandler.sharedInstance().registerWithDefaultDelegate()
            print("Setting google authentication handler")
            IMFGoogleAuthenticationHandler.sharedInstance().registerWithDefaultDelegate()
            print("Setting custom authentication handler")
            IMFClient.sharedInstance().registerAuthenticationDelegate(nil, forRealm: "SmartQAuth")
            
            //analytics
            IMFAnalytics.sharedInstance().startRecordingApplicationLifecycleEvents()
            /*
            //setup push with interactive notifications
            let acceptAction = UIMutableUserNotificationAction()
            acceptAction.identifier = "ACCEPT_ACTION"
            acceptAction.title = "Accept"
            acceptAction.destructive = false
            acceptAction.authenticationRequired = false
            acceptAction.activationMode = UIUserNotificationActivationMode.Foreground
            
            let declineAction = UIMutableUserNotificationAction()
            declineAction.identifier = "DECLINE_ACTION"
            declineAction.title = "Decline"
            declineAction.destructive = true
            declineAction.authenticationRequired = false
            declineAction.activationMode = UIUserNotificationActivationMode.Background
            
            let pushCategory = UIMutableUserNotificationCategory()
            pushCategory.identifier = "TODO_CATEGORY"
            pushCategory.setActions([acceptAction, declineAction], forContext: UIUserNotificationActionContext.Default)
            
            let notificationTypes: UIUserNotificationType = UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound
            let notificationSettings: UIUserNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: NSSet(array:[pushCategory]) as Set<NSObject>)
            
            //UIUserNotificationSettings(forTypes: notificationTypes, categories: <#Set<NSObject>?#>)
            
            application.registerUserNotificationSettings(notificationSettings)
            application.registerForRemoteNotifications()
            */
        }
        return true

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.sd.th.ibm.SmartQ" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as! NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SmartQ", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SmartQ.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        /*
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict as [NSObject : AnyObject])
            //NSError(domain: <#String#>, code: <#Int#>, userInfo: <#[NSObject : AnyObject]?#>)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        */
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            /*
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
            }*/
        }
    }


}

