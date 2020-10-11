//
//  MainTabBar.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

//TODO: Singletone 으로 바꿀 필요가 있음
var globalToken: String?

class MainTabBar: UITabBarController {
     
    func authenticateUser() {
        let prefs = UserDefaults.standard
        if let data = prefs.data(forKey: "accessToken"),
           let token = NSKeyedUnarchiver.unarchiveObject(with: data) as? String {
            globalToken = token
        } else {
            let vc = LoginViewController()
            presentViewControllerAsRootVC(with: vc)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUser()
        view.tintColor = .black
        viewControllers = [
            createNavController(viewController: TrainingViewController(), title: "Training", imageName: "training"),
            createNavController(viewController: ActivityController(), title: "Activity", imageName: "activity"),
            createNavController(viewController: MatchController(), title: "Match", imageName: "match"),
            createNavController(viewController: SocialViewController(), title: "Social", imageName: "social"),
            createNavController(viewController: MyPageController(), title: "Profile", imageName: "mypage"),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
        
    }
}
