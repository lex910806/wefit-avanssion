//
//  MessageCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class MessageCell: UICollectionViewCell {
     
    // MARK: - Properties
    
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = .systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        tv.text = "text?"
        return tv
    }()
    
    let bubbleContainer: UIView = {
       let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: .zero)
        
        addSubview(profileImageView)
        profileImageView.anchor(leading: leadingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 8, bottom: -4, right: 0))
        profileImageView.constrainWidth(constant: 32)
        profileImageView.constrainHeight(constant: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, leading: bubbleContainer.leadingAnchor, bottom: bubbleContainer.bottomAnchor, trailing: bubbleContainer.trailingAnchor, padding: .init(top: 4, left: 12, bottom: 4, right: 12))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func configure() {
        guard let message = message else { return }
        
        let viewModel = MessageViewModel(message: message)
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageMessageColor
        textView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        
        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
}
