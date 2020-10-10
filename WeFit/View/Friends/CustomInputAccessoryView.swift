//
//  CustomInputAccessoryView.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit


import UIKit


protocol CustomInputAccessoryViewDelegate: class {
    func inputView(_ inputView:CustomInputAccessoryView, wantsToSend message: String)
    func actionDidSelected(_ inputView:CustomInputAccessoryView)
}

class CustomInputAccessoryView: UIView {
    
    
    // MARK: - Properties
    
    weak var delegate: CustomInputAccessoryViewDelegate?
    
    private lazy var messageInputTextView: UITextView = {
       let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.delegate = self
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor(200,199,204).cgColor
        return tv
    }()
    
    let actionButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"match_icon"), for: .normal)
        
        btn.setTitleColor(.systemPurple, for: .normal)
        return btn
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"send_icon"), for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        backgroundColor = .init(236,236,236)
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(actionButton)
        actionButton.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 8, paddingRight: 4)
        actionButton.setDimensions(height: 50, width: 50)
        
        addSubview(sendButton)
        sendButton.anchor(top:topAnchor, right: rightAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top: topAnchor, left: actionButton.rightAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: sendButton.leftAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messageInputTextView.leftAnchor, paddingLeft: 8)
        placeholderLabel.centerY(inView: messageInputTextView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func renounceFocus() {
        messageInputTextView.endEditing(true)
    }

    func addActions() {
        actionButton.addTarget(self, action: #selector(handleActionBtn), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
    }
    
    
    // MARK: - Selectors
    
    @objc func handleActionBtn(sender: UIButton) {
        delegate?.actionDidSelected(self)
    }
    
    @objc func handleSendMessage() {
        guard let message = messageInputTextView.text else { return }
        delegate?.inputView(self, wantsToSend: message)
    }
    
    // MARK: - Helpers
    
    func clearMessageText() {
        messageInputTextView.text = nil
        placeholderLabel.isHidden = false
    }
    
}

extension CustomInputAccessoryView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !self.messageInputTextView.text.isEmpty
    }
}
