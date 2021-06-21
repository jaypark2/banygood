//
//  AppDelegate.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit
import NCMB

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NCMB.setApplicationKey("ac7a0d13d7eb1c4dc27a5f8ea1ca8a7eb68e3fc8578c9915766590b1e74603fb", clientKey: "3ed4e02391d31162a83168de0a8b4f1c8647e130d29648b63aaadf3b9f9c6aed")
        
        sleep(2) // <<<<<<<<<<<< 追加
        
        let ud = UserDefaults.standard
        if ud.object(forKey: "userName") == nil {
            NCMBUser.enableAutomaticUser()
            NCMBUser.automaticCurrentUser { (user, error) in
                if error != nil {
                    print(error)
                } else {
                    ud.set(user?.objectId, forKey: "userName")
                    print(ud.object(forKey: "userName"))
                     let groupACL = NCMBACL()
                    groupACL.setPublicReadAccess(true)
                    user!.acl = groupACL
                    user!.save(nil)
                }
            }
        }
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

