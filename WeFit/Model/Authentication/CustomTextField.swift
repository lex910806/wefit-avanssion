//
//  CustomTextField.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholer: String){
        super.init(frame: .zero)
        
        borderStyle = .none
        font = UIFont.boldSystemFont(ofSize: 16)
        textColor = .black
        keyboardAppearance = .dark
        attributedPlaceholder = NSAttributedString(string: placeholer, attributes: [.foregroundColor : UIColor.darkGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

