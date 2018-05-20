//
//  AppDelegate.swift
//  AI-in-iOS
//
//  Created by Xianning Liu  on 02/02/2018.
//  Copyright © 2018 Xianning Liu . All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
