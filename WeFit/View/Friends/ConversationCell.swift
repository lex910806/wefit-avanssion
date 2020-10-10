//
//  ChatListCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit
import Firebase

class ConversationCell: UICollectionViewCell {
    var conversation: Conversation! {
        didSet {
            self.avatar.sd_setImage(with: conversation.user.avatarUrl)
            self.name.text = conversation.user.nickName
            self.message.text = conversation.message.text
            let date = conversation.message.timestamp.dateValue()
            if Calendar.current.isDateInToday(date) {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "hh:mm a"
                self.dateLabel.text = dateFormatterPrint.string(from: date)
            } else {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MM/dd hh:mm a"
                self.dateLabel.text = dateFormatterPrint.string(from: date)
                
            }
        }
    }
    
   
    
    let avatar = UIImageView(cornerRadius: 21)
    let name = UILabel(text: "Friend", font: .systemFont(ofSize: 15))
    let dateLabel = UILabel(text: "", font: .systemFont(ofSize: 11))
    let message = UILabel(text: "", font: .systemFont(ofSize: 13))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dateLabel.textColor = .init(130,130,130)
        message.textColor = .init(130,130,130)
        avatar.backgroundColor = .lightGray
        let stackView = UIStackView(arrangedSubviews: [
            avatar,
            VerticalStackView(arrangedSubviews: [
                UIStackView(arrangedSubviews: [name, UIView(), dateLabel]),
                message
            ], spacing: 4)
        ], customSpacing: 18)
        
        avatar.constrainWidth(constant: 42)
        avatar.constrainHeight(constant: 42)
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
