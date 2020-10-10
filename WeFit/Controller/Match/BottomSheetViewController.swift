//
//  BottomSheetViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    var exerciseHandler: ((Exercise) -> Void)?
    @objc private func exercisehandler(sender: UIButton) {
        let ex = Exercise(rawValue: sender.tag)
        exerciseHandler?(ex!)
    }
    
    var opponentHandler: ((Int) -> Void)?
    @objc private func opponenthandler(sender: UIButton) {
        opponentHandler?(sender.tag)
    }
    public func makeOpponentView() {
        let btn = UIButton()
        btn.setImage(UIImage(named: "friends"), for: .normal)
        btn.tag = 0
        btn.addTarget(self, action: #selector(opponenthandler), for: .touchUpInside)
        btn.constrainHeight(constant: 166)
        btn.constrainWidth(constant: 164)
        
        let btn2 = UIButton()
        btn2.setImage(UIImage(named: "random"), for: .normal)
        btn2.tag = 1
        btn2.addTarget(self, action: #selector(opponenthandler), for: .touchUpInside)
        btn2.constrainHeight(constant: 166)
        btn2.constrainWidth(constant: 164)
        
        let stackView = UIStackView(arrangedSubviews: [
            UIView(),
            btn,
            btn2,
            UIView()
        ], customSpacing: 16)
        stackView.alignment = .center
        view.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 143, right: 16))
    }
    
    public func makeExerciseView() {
        let ex = ["pushup", "squat", "lunge", "crunch"]
        var btns = [UIButton]()
        
        for (idx, value) in ex.enumerated() {
            let btn = UIButton()
            btn.setImage(UIImage(named: value), for: .normal)
            btn.tag = idx
            btn.addTarget(self, action: #selector(exercisehandler), for: .touchUpInside)
            btn.constrainHeight(constant: 80)
            btns.append(btn)
        }
        
        let stackView = VerticalStackView(arrangedSubviews: btns, spacing: 15)
        
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 143, right: 16))
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
