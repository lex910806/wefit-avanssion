//
//  ContainerCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit

class GuideContainerCell: UICollectionViewCell {
    
    let title = UILabel(text: "Guide", font: .systemFont(ofSize: 20, weight: .semibold))
    let horizontalVC = GuideViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let stackView = VerticalStackView(arrangedSubviews: [
            title,
            horizontalVC.view
        ], spacing: 10)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
