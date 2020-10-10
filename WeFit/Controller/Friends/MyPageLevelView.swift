//
//  MyPageLevelView.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//

import UIKit

class MyPageLevelView: UIView {

    let whiteBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#ffffff")
        return view
    }()

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()

    let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#000000")
        label.text = "Lv. 3  Beginner"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("O", for: .normal)
        return button
    }()

    let levelProgressContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "DBDBDB")
        view.layer.cornerRadius = 4
        return view
    }()

    let levelProgressBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "F61D44")
        view.layer.cornerRadius = 4
        return view
    }()

    let levelCounter: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9360/36000"
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(hex: "#828282")
        return label
    }()

    let horizontalSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#DCDCDC")
        return view
    }()

    let rankLabel: UIView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(hex: "#000000")
        label.text = "Your Rank"
        return label
    }()

    let rankTopLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#000000")
        label.text = "top"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()

    let rankCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#000000")
        label.text = "43%"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold).italic
        return label
    }()

    let verticalSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#DCDCDC")
        return view
    }()

    let medalLabel: UIView = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(hex: "#000000")
        label.text = "Your Medal"
        return label
    }()

    let medalImageView: UIView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ic_medal")
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "#ededed")
        addSubview(whiteBackground)
        addSubview(contentView)
        addSubview(levelLabel)
        addSubview(infoButton)
        addSubview(levelProgressContainer)
        addSubview(levelProgressBar)
        addSubview(levelCounter)
        addSubview(horizontalSeparator)
        addSubview(rankLabel)
        addSubview(rankTopLabel)
        addSubview(rankCounterLabel)
        addSubview(verticalSeparator)
        addSubview(medalLabel)
        addSubview(medalImageView)

        NSLayoutConstraint.activate([
            whiteBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            whiteBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            whiteBackground.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            whiteBackground.heightAnchor.constraint(equalToConstant: 60),
        ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            contentView.bottomAnchor.constraint(equalTo: verticalSeparator.bottomAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            levelLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            levelLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            infoButton.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor, constant: 0),
            infoButton.leftAnchor.constraint(equalTo: levelLabel.rightAnchor, constant: 4),
        ])

        NSLayoutConstraint.activate([
            levelProgressContainer.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 20),
            levelProgressContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            levelProgressContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            levelProgressContainer.heightAnchor.constraint(equalToConstant: 8),
        ])

        NSLayoutConstraint.activate([
            levelProgressBar.topAnchor.constraint(equalTo: levelProgressContainer.topAnchor, constant: 0),
            levelProgressBar.bottomAnchor.constraint(equalTo: levelProgressContainer.bottomAnchor, constant: 0),
            levelProgressBar.leftAnchor.constraint(equalTo: levelProgressContainer.leftAnchor, constant: 0),
            levelProgressBar.widthAnchor.constraint(equalTo: levelProgressContainer.widthAnchor, multiplier: 0.2),
        ])

        NSLayoutConstraint.activate([
            levelCounter.topAnchor.constraint(equalTo: levelProgressContainer.bottomAnchor, constant: 5),
            levelCounter.rightAnchor.constraint(equalTo: levelProgressContainer.rightAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            horizontalSeparator.topAnchor.constraint(equalTo: levelCounter.bottomAnchor, constant: 10),
            horizontalSeparator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            horizontalSeparator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            horizontalSeparator.heightAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor, constant: 10),
            rankLabel.leftAnchor.constraint(equalTo: horizontalSeparator.leftAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            rankCounterLabel.bottomAnchor.constraint(equalTo: verticalSeparator.bottomAnchor, constant: 0),
            rankCounterLabel.leftAnchor.constraint(equalTo: rankLabel.leftAnchor, constant: 0),
            rankCounterLabel.rightAnchor.constraint(equalTo: verticalSeparator.leftAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            rankTopLabel.bottomAnchor.constraint(equalTo: rankCounterLabel.topAnchor, constant: 0),
            rankTopLabel.centerXAnchor.constraint(equalTo: rankCounterLabel.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            verticalSeparator.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            verticalSeparator.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor, constant: 10),
            verticalSeparator.heightAnchor.constraint(equalToConstant: 92),
            verticalSeparator.widthAnchor.constraint(equalToConstant: 1),
        ])

        NSLayoutConstraint.activate([
            medalLabel.topAnchor.constraint(equalTo: horizontalSeparator.bottomAnchor, constant: 10),
            medalLabel.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 15),
        ])

        NSLayoutConstraint.activate([
            medalImageView.bottomAnchor.constraint(equalTo: verticalSeparator.bottomAnchor, constant: -4),
            medalImageView.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 0),
            medalImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            medalImageView.heightAnchor.constraint(equalToConstant: 50),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
