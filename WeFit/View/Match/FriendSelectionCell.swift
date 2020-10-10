//
//  FriendSelectionCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import UIKit

class FriendSelectionCell: UITableViewCell {
    var friend: FriendListViewModel! {
        didSet {
            if let urlStr = friend.avatar_url {
                icon.sd_setImage(with: URL(string: urlStr))
            }
            label.text = friend.nickName
        }
    }
    
    let radio = UIImageView(cornerRadius: 12)
    let icon = UIImageView(cornerRadius: 21)
    let label = UILabel(text: "", font: .systemFont(ofSize: 17, weight: .regular))
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        radio.setDimensions(height: 24, width: 24)
        icon.setDimensions(height: 42, width: 42)
        icon.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [UIView(), radio, icon, label, UIView()],
                                    customSpacing: 18)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            radio.image = UIImage(named: "selected")
        } else {
            radio.image = UIImage(named: "deselected")
        }
    }
}
