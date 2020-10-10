//
//  MyPageActionView.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//

import UIKit

class MyPageActionView: UIView {

    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(hex: "#000000")
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(hex: "#ffffff")
        layer.cornerRadius = 10
        addSubview(iconImageView)
        addSubview(textLabel)

        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
        ])

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            textLabel.heightAnchor.constraint(equalToConstant: 36),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(icon: String, text: String) {
        iconImageView.image = UIImage(named: icon)
        textLabel.text = text
    }
}
