//
//  AppDelegate.swift
//  Runner
//
//  Created by Kamran Pirwani on 3/21/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import UIKit
import Flutter
import AdSupport

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var bridge: NativeBridging?
    
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let adManager = AdManager.shared
    adManager.rootViewController = controller
    bridge = NativeBridging(binaryMessenger: controller.binaryMessenger, adManager: adManager)
    GeneratedPluginRegistrant.register(with: self)
        #if DEBUG
        print("ADID: \(self.identifierForAdvertising())")
        #endif
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    #if DEBUG
    func identifierForAdvertising() -> String? {
        // Check whether advertising tracking is enabled
        guard ASIdentifierManager.shared().isAdvertisingTrackingEnabled else {
            return nil
        }

        // Get and return IDFA
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    #endif
    
}

