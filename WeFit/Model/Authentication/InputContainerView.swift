//
//  InputContainerView.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import UIKit

class InputContainerView: UIView {
    init(textField: UITextField){
        super.init(frame: .zero)
        
        constrainHeight(constant: 50)
        
        addSubview(textField)
        textField.centerYInSuperview()
        textField.anchor(top: nil,
                          leading: leadingAnchor,
                          bottom: bottomAnchor,
                          trailing: trailingAnchor)

        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.init(189, 189, 189)
        addSubview(dividerView)
        dividerView.anchor(top:nil,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: trailingAnchor,
                           padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        dividerView.constrainHeight(constant: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
