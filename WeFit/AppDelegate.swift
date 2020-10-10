//
//  AppDelegate.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        settingRootVC()
        
//        let decoded = Jwt.decode("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
//        print(decoded)
//        
//        let credentials = RegistrationCredentials(id: 2, email: "lex910806@gmail.com", name: "TestUser", nickName: "jh")
//        UserService.createUser(credentials: credentials, completion: nil)
        return true
    }
    
    func settingRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let nav = UINavigationController(rootViewController: LoginViewController())
//        window?.rootViewController = nav
        window?.rootViewController = MainTabBar()
        window?.makeKeyAndVisible()
    }
}

