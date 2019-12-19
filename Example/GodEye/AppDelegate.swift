//
//  AppDelegate.swift
//  GodEye
//
//  Created by zixun on 12/27/2016.
//  Copyright (c) 2016 zixun. All rights reserved.
//

import UIKit
import GodEye
import CCProgressHUDKit

func dispatch_async_safely_to_main_queue(_ block: @escaping ()->()) {
    dispatch_async_safely_to_queue(DispatchQueue.main, block)
}

// This methd will dispatch the `block` to a specified `queue`.
// If the `queue` is the main queue, and current thread is main thread, the block
// will be invoked immediately instead of being dispatched.
func dispatch_async_safely_to_queue(_ queue: DispatchQueue, _ block: @escaping ()->()) {
    if queue === DispatchQueue.main && Thread.isMainThread {
        block()
    } else {
        queue.async {
            block()
        }
    }
}

func alert(t:String, _ m:String) {
    
    MBProgressHUD.showSuccess("\(t) \n \(m)")
//    let alertView = UIAlertView()
//    alertView.title = t
//    alertView.message = m
//    alertView.addButton(withTitle: "OK")
//    alertView.show()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        GodEye.makeEye(with: self.window!)
//        
        
        
        let configuration = Configuration()
        configuration.command.add(command: "test", description: "test command") { () -> (String) in
            return "this is test command result"
        }
        configuration.command.add(command: "info", description: "print test info") { () -> (String) in
            return "info"
        }
        
        GodEye.makeEye(with: self.window!, configuration: configuration)
        return true
    }
}

