//
//  AppDelegate.swift
//  AccountAlertView
//
//  Created by Joe Nguyen on 13/08/2014.
//  Copyright (c) 2014 oneyenjug. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
                            
    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {

        let viewController = ViewController()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
        
        return true
    }
}

