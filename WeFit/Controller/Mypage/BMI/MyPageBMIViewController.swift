//
//  MyPageBMIViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import Parchment
import UIKit

class MyPageBMIViewController: UIViewController {

    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_back"), for: .normal)
        button.addTarget(self, action: #selector(onBackButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
        ])

        let viewControllers = [
            MyPageBMICalculatorViewController(),
            MyPageBMIFacialViewController(),
        ]

        let pagingViewController = PagingViewController(viewControllers: viewControllers)
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
            pagingViewController.view.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            pagingViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            pagingViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        pagingViewController.didMove(toParent: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc
    private func onBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
