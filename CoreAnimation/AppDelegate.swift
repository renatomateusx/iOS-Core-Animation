//
//  AppDelegate.swift
//  CoreAnimation
//
//  Created by Renato Mateus on 30/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow()
    window.makeKeyAndVisible()
    window.rootViewController = UINavigationController(rootViewController: ViewController())
    self.window = window
    
    return true
  }

  

}

