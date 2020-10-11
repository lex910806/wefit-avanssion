//
//  MatchCell.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

protocol MatchCellDelegate: class {
    func matchCellDidTap(accept match: Match)
    func matchCellDidTap(decline match: Match)
}
class MatchCell: UICollectionViewCell {
    weak var delegate: MatchCellDelegate?
    var match: Match! {
        didSet {
            ChatService.fetchUser(withUid: String(match.fromId)) { (user) in
                DispatchQueue.main.async {
                    self.avatar.sd_setImage(with: user.avatarUrl)
                }
            }
            let emphasis: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]
            let normal: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize: 14, weight: .regular)]
            
            let str = NSMutableAttributedString(string: match.fromName, attributes: emphasis)
            str.append(NSAttributedString(string: " just challenged\nyou to a ", attributes: normal))
            str.append(NSAttributedString(string: match.exercise.name(), attributes: emphasis))
            str.append(NSAttributedString(string: " match!", attributes: normal))
            label.attributedText = str
        }
    }
    
    let avatar = UIImageView(cornerRadius: 19)
    let label = UILabel(text: "Bill Anderson just challenged\nyou to a pushup match!", font: .systemFont(ofSize: 14, weight: .regular), numberOfLines: 2)
    let declineBtn = UIButton(title: "Decline")
    let acceptBtn = UIButton(title: "Accept")
    
    @objc func declineHandler() {
        delegate?.matchCellDidTap(decline: match)
    }
    @objc func accentHandler() {
        delegate?.matchCellDidTap(accept: match)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        avatar.backgroundColor = .lightGray
        avatar.setDimensions(height: 38, width: 38)
        declineBtn.constrainHeight(constant: 41)
        acceptBtn.constrainHeight(constant: 41)
        
        declineBtn.backgroundColor = .init(130, 130, 130)
        acceptBtn.backgroundColor = .init(246, 29, 68)
        
        declineBtn.layer.cornerRadius = 5
        acceptBtn.layer.cornerRadius = 5
        
        declineBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        acceptBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        acceptBtn.addTarget(self, action: #selector(accentHandler), for: .touchUpInside)
        declineBtn.addTarget(self, action: #selector(declineHandler), for: .touchUpInside)
        declineBtn.setTitleColor(.white, for: .normal)
        acceptBtn.setTitleColor(.white, for: .normal)
        label.constrainHeight(constant: 60)
        let btns = UIStackView(arrangedSubviews: [declineBtn, acceptBtn], customSpacing: 13)
        btns.distribution = .fillEqually
        let stackView = VerticalStackView(arrangedSubviews: [
            
            UIStackView(arrangedSubviews: [avatar, label], customSpacing: 15),
            btns,
            
        ], spacing: 15)
        
        let container = UIView()
        container.backgroundColor = .init(242, 242, 242)
        container.layer.cornerRadius = 10
        container.clipsToBounds = true
        addSubview(container)
        container.fillSuperview()
        
        container.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
        stackView.alignment = .fill
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
