//
//  SetupMatchView.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit

protocol SetupMatchViewDelegate: class {
    func setupMatch(_ view: SetupMatchView, exercise button: UIButton)
    func setupMatch(_ view: SetupMatchView, user button: UIButton)
}

class SetupMatchView: UIView {
    weak var delegate: SetupMatchViewDelegate?
    let exerciseSelectBtn = UIButton(title: "Pushup")
    let iconImage = UIButton()
    let vsLabel = UILabel(text: "VS", font: UIFont.systemFont(ofSize: 42).boldItalic)
    let avatar = UIImageView(cornerRadius: 48)
    
    @objc func userSelect(sender: UIButton) {
        delegate?.setupMatch(self, user: sender)
    }
    
    @objc func exerciseSelect(sender: UIButton) {
        delegate?.setupMatch(self, exercise: sender)
    }
    
    init(me: User) {
        super.init(frame: .zero)
        
        exerciseSelectBtn.setImage(UIImage(named: "bottom_arrow"), for: .normal)
        exerciseSelectBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        exerciseSelectBtn.backgroundColor = .init(23, 193, 96)
        exerciseSelectBtn.layer.cornerRadius = 19
        exerciseSelectBtn.tintColor = .white
        exerciseSelectBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 29)
        exerciseSelectBtn.addTarget(self, action: #selector(exerciseSelect), for: .touchUpInside)
        
        iconImage.setImage(UIImage(named: "plus"), for: .normal)
        
        iconImage.backgroundColor = .lightGray
        iconImage.layer.cornerRadius = 48
        iconImage.clipsToBounds = true
        iconImage.addTarget(self, action: #selector(userSelect), for: .touchUpInside)
        
        vsLabel.textColor = .white
        if me.avatarUrl == nil {
            avatar.image = UIImage(named: "person")
        } else {
            avatar.sd_setImage(with: me.avatarUrl)
        }
        
        avatar.setDimensions(height: 96, width: 96)
        iconImage.setDimensions(height: 96, width: 96)
        exerciseSelectBtn.setDimensions(height: 38, width: 140)
        
        let spacingV = UIView()
        spacingV.constrainHeight(constant: 31)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            
            exerciseSelectBtn,
            spacingV,
            UIStackView(arrangedSubviews: [
                iconImage,
                vsLabel,
                avatar], customSpacing: 20),
            UIView()
        ])
        
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 32, bottom: 20, right: 32))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
