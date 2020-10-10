//
//  MatchHeader.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class MatchHeader: UICollectionReusableView {
    
    let title = UILabel(text: "", font: .systemFont(ofSize: 20, weight: .semibold))
    
    var segmentedTitle: [String]? {
        didSet {
            subviews.forEach{ $0.removeFromSuperview()}
            let container = UIView()
            container.addSubview(title)
            title.anchor(leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
            if segmentedTitle?.count ?? 0 > 0 {
                segment.titles = segmentedTitle ?? []
                segment.constrainHeight(constant: 30)
                
                let stackView = VerticalStackView(arrangedSubviews: [
                    UIView(),
                    container,
                    segment
                ], spacing: 10)
                addSubview(stackView)
                stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 7, right: 0))
            } else {
                let stackView = VerticalStackView(arrangedSubviews: [
                    UIView(),
                    container
                ])
                addSubview(stackView)
                stackView.fillSuperview(padding: .init(top: 0, left: 0, bottom: 7, right: 0))
            }
            
        }
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    var segment: PinterestSegment = {
        var  style = PinterestSegmentStyle()
        
        style.indicatorColor = .init(246, 29, 68)
        style.titleMargin = 15
        style.titlePendingHorizontal = 10
        style.titlePendingVertical = 10
        style.titleFont = UIFont.boldSystemFont(ofSize: 14)
        style.normalTitleColor = UIColor.lightGray
        style.selectedTitleColor = .white
        
        let sg = PinterestSegment(frame: .zero, segmentStyle: style, titles: [])
        
        return sg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
