//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroListViewController")
        window?.rootViewController = rootVC
        return true
    }

}

