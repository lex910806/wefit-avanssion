//
//  AttendenceContainerCell.swift
//  WeFit
//
//  Created by sangwon on 2020/10/10.
//

import UIKit

class AttendenceContainerCell: UICollectionViewCell {
    
    let title = UILabel(text: "Attendence", font: .systemFont(ofSize: 20, weight: .semibold))
    let horizontalVC = AttendenceController()
    
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
