//
//  SearchResultCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    var result: UserSearchResult! {
        didSet {
            if let url = result.avatar_url {
                avatar.sd_setImage(with: URL(string: url))
            }
            name.text = result.nickName
        }
    }
       
    let avatar = UIImageView(cornerRadius: 21)
    let name = UILabel(text: "Friend", font: .systemFont(ofSize: 17))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatar.backgroundColor = .lightGray
        let stackView = UIStackView(arrangedSubviews: [
            avatar, name
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
