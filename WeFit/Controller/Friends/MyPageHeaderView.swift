//
//  MyPageHeaderView.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//

import UIKit

class MyPageHeaderView: UIView {

    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.backgroundColor = .lightGray
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 72/2
        return iv
    }()

    let identityStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.axis = .vertical
        return sv
    }()

    let identityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#000000")
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.text = "Sangwon Park"
        return label
    }()

    let identityEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#bdbdbd")
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Sangwon@wefit.com"
        return label
    }()

    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor(hex: "#4F4F4F"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 11, bottom: 5, right: 11)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        return button
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "#ffffff")
        addSubview(profileImageView)
        addSubview(identityStackView)
        identityStackView.addArrangedSubview(identityNameLabel)
        identityStackView.addArrangedSubview(identityEmailLabel)
        addSubview(editButton)

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 72),
            profileImageView.heightAnchor.constraint(equalToConstant: 72),
        ])

        NSLayoutConstraint.activate([
            identityStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            identityStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            editButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0),
            editButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
