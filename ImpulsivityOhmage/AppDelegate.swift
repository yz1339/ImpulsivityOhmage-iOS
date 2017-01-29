
//
//  AppDelegate.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 1/26/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit
import OhmageOMHSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var ohmageManager: OhmageOMHManager! = {
        let omhClientDetails = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "OMHClient", ofType: "plist")!)
        
        guard let baseURL = omhClientDetails?["OMHBaseURL"] as? String,
            let clientID = omhClientDetails?["OMHClientID"] as? String,
            let clientSecret = omhClientDetails?["OMHClientSecret"] as? String else {
                fatalError("Could not initialze OhmageManager")
        }
        
        if OhmageOMHManager.config(baseURL: baseURL,
                                   clientID: clientID,
                                   clientSecret: clientSecret,
                                   queueStorageDirectory: "ohmageSDK",
                                   store: OhmageCredentialStore.sharedInstance,
                                   logger: LogManager.sharedInstance) {
            return OhmageOMHManager.shared
        }
        else {
            fatalError("Could not initialze OhmageManager")
        }
    }()
    
    open func showViewController() -> Bool {
        
        guard let window = self.window else {
            return false
        }
        
        if CTFAppState.sharedInstance.isSignedInOrSkipped {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = mainStoryboard.instantiateInitialViewController()
            window.rootViewController = vc
        }
        else {
            let onboardingStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = onboardingStoryboard.instantiateInitialViewController()
            window.rootViewController = vc
        }
        
        return true
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if UserDefaults.standard.object(forKey: "FirstRun") == nil {
            UserDefaults.standard.set("1stRun", forKey: "FirstRun")
            UserDefaults.standard.synchronize()
            
            OhmageCredentialStore.clearKeychain()

        }

        return self.showViewController()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

