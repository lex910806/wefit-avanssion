//
//  ChallengeCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit

class ChallengeCell: MessageCell {
    
    private let iv: UIImageView = {
        let view = UIImageView()
        view.setDimensions(height: 120, width: 186)
        return view
    }()
    private let btn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setDimensions(height: 34, width: 186)
        btn.setTitle("Start Match", for: .normal)
        btn.backgroundColor = .init(246, 29, 68)
        btn.layer.cornerRadius = 5
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        btn.titleLabel?.textColor = .white
        btn.tintColor = .white
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = VerticalStackView(arrangedSubviews: [
            iv,
            btn
        ],spacing: 10)
        stackView.setDimensions(height: 152, width: 210)
        bubbleContainer.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 8, left: 10, bottom: 8, right: 10))
    }
    
    override func configure() {
        super.configure()
        textView.text = ""
        iv.image = message?.exercise.smallImage()
        btn.isEnabled = !(message?.isFromCurrentUser ?? false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
