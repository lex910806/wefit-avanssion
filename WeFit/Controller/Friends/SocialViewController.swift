//
//  SocialViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import Parchment
import UIKit

class SocialViewController: UIViewController {
    
    @objc func friendAdd(){
        let vc = FriendSearchController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        navigationController?.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"user_plus"), style: .done, target: self, action: #selector(friendAdd))
        let viewControllers = [
            FriendListViewController(),
            ConversationsViewController(),
        ]
        
        let pagingViewController = PagingViewController(viewControllers: viewControllers)
        pagingViewController.borderOptions = .hidden
        pagingViewController.indicatorOptions = .visible(height: 4,
                                                         zIndex: Int.max,
                                                         spacing: .zero,
                                                         insets: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40))
        pagingViewController.indicatorColor = UIColor.black
        pagingViewController.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        pagingViewController.selectedFont = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.semibold)
        pagingViewController.textColor = UIColor.lightGray
        pagingViewController.selectedTextColor = UIColor.black
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            pagingViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        pagingViewController.didMove(toParent: self)
    }
}
