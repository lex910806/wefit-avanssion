//
//  ProfileController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import AloeStackView
import UIKit

class MyPageController: UIViewController {
    
    let stackView: AloeStackView = {
        let sv = AloeStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = UIColor(hex: "#ededed")
        sv.rowInset = .zero
        sv.hidesSeparatorsByDefault = true
        return sv
    }()
    
    var levelView: MyPageLevelView!
    var actionsView: MyPageActionsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        [levelView.contentView, actionsView.bodyStep, actionsView.bmiCalculator, actionsView.settings]
            .forEach{ $0.addShadow(x: 0, y: 2, r: 6) }
    }
    
    private func setupViews() {
        setupHeaderView()
        setupLevelView()
        setupActionsView()
    }
    
    private func setupHeaderView() {
        let view = MyPageHeaderView()
        stackView.addRow(view)
    }
    
    private func setupLevelView() {
        levelView = MyPageLevelView()
        stackView.addRow(levelView)
    }
    
    private func setupActionsView() {
        actionsView = MyPageActionsView()
        let bodyGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBodyState))
        let bmiGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onBMICalculator))
        let settingsGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onSettings))
        actionsView.bodyStep.addGestureRecognizer(bodyGestureRecognizer)
        actionsView.bmiCalculator.addGestureRecognizer(bmiGestureRecognizer)
        actionsView.settings.addGestureRecognizer(settingsGestureRecognizer)
        stackView.addRow(actionsView)
    }
    
    @objc
    private func onBodyState() {
        print("onBodyState")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc
    private func onSettings() {
        let calorieSearchController = CalorieSearchViewController()
        calorieSearchController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(calorieSearchController, animated: true)
    }
    @objc
    private func onBMICalculator() {
        let bmiViewController = MyPageBMIViewController()
        bmiViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(bmiViewController, animated: true)
    }
}
