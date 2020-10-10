//
//  RecordCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class RecordCell: UICollectionViewCell {
    
    var record: Record! {
        didSet {
            exerciseIndicator.text = record.exercise.name()
            exerciseIndicator.backgroundColor = record.exercise.color()
            
            if record.amIWin {
                rightResultLabel.text = "win"
                leftResultLabel.text = "lose"
                rightIndicatorImage.alpha = 1
                leftIndicatorImage.alpha = 0
            } else {
                leftResultLabel.text = "win"
                rightResultLabel.text = "lose"
                leftIndicatorImage.alpha = 1
                rightIndicatorImage.alpha = 0
            }
            
            leftAvatar.sd_setImage(with: record.opponent.avatarUrl)
            leftValueLabel.text = "\(record.opponent.value) times"
            
            rightAvatar.sd_setImage(with: record.me.avatarUrl)
            rightValueLabel.text = "\(record.value) times"
        }
    }
    
    let exerciseIndicator = UILabel(text: "", font: .systemFont(ofSize: 11, weight: .semibold))
    
    let leftIndicatorImage = UIImageView(image: UIImage(named: "crown"))
    let leftResultLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .bold))
    let leftValueLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium))
    let leftAvatar = UIImageView(cornerRadius: 24)
    
    let rightIndicatorImage = UIImageView(image: UIImage(named: "crown"))
    let rightResultLabel = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .bold))
    let rightValueLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .medium))
    let rightAvatar = UIImageView(cornerRadius: 24)
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        exerciseIndicator.textColor = .white
        exerciseIndicator.layer.cornerRadius = 19 / 2
        exerciseIndicator.constrainHeight(constant: 19)
        exerciseIndicator.constrainWidth(constant: 60)
        exerciseIndicator.textAlignment = .center
        exerciseIndicator.clipsToBounds = true
        
        leftResultLabel.textColor = .init(79, 79, 79)
        rightResultLabel.textColor = .init(246, 29, 68)
        
        leftResultLabel.textAlignment = .left
        leftValueLabel.textAlignment = .left
        
        rightResultLabel.textAlignment = .right
        rightValueLabel.textAlignment = .right
        
        leftAvatar.setDimensions(height: 48, width: 48)
        rightAvatar.setDimensions(height: 48, width: 48)
        
        
        leftIndicatorImage.setDimensions(height: 18, width: 18)
        rightIndicatorImage.setDimensions(height: 18, width: 18)
        
        let container = UIView()
        container.addSubview(exerciseIndicator)
        
        exerciseIndicator.centerInSuperview()
        let indicatorView = UIStackView(arrangedSubviews: [
            leftIndicatorImage,
            container,
            rightIndicatorImage,
        ])
        indicatorView.alignment = .center
      
        let centerContainer = UIView()
        let vsLabel = UILabel(text: "VS", font: UIFont.systemFont(ofSize: 24).boldItalic)
        
        centerContainer.addSubview(vsLabel)
        vsLabel.centerXInSuperview()
        vsLabel.anchor(bottom: centerContainer.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 20, right: 0))
        
        centerContainer.addSubview(leftAvatar)
        leftAvatar.anchor(trailing: vsLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10))
        leftAvatar.centerY(inView: vsLabel)
        
        centerContainer.addSubview(rightAvatar)
        rightAvatar.anchor(leading: vsLabel.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        rightAvatar.centerY(inView: vsLabel)
        
//        centerContainer.backgroundColor = .init(243, 243, 243)
        let resultView = UIStackView(arrangedSubviews: [
            VerticalStackView(arrangedSubviews: [
                leftResultLabel,
                leftValueLabel
            ]),
            centerContainer,
            VerticalStackView(arrangedSubviews: [
                rightResultLabel,
                rightValueLabel
            ]),
        ])
        
        resultView.alignment = .center
        
        
        let stackView = VerticalStackView(arrangedSubviews: [
            indicatorView,
            UIView(),
            resultView,
            UIView()
        ], spacing: 2)
                
//        let backgroundView = UIView()
        centerContainer.layer.cornerRadius = 10
        centerContainer.clipsToBounds = true
        centerContainer.backgroundColor = .init(243, 243, 243)
        addSubview(centerContainer)
        centerContainer.fillSuperview()
        
        centerContainer.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
