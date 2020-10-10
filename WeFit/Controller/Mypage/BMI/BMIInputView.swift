//
//  BMIInputView.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//

import UIKit

class BMIInputView: UIView {

    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#F2F2F2")
        view.layer.cornerRadius = 10
        return view
    }()

    let inputLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(hex: "#000000")
        return label
    }()

    let inputTextfield: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(hex: "#ffffff")
        tf.layer.cornerRadius = 5
        tf.layer.borderWidth = 1
        tf.keyboardType = .numberPad
        tf.layer.borderColor = UIColor(hex: "#bdbdbd")?.cgColor
        tf.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.rightView = paddingView
        tf.rightViewMode = .always
        return tf
    }()

    let inputMeasureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(hex: "#000000")
        label.textAlignment = .right
        return label
    }()

    init() {
        super.init(frame: .zero)
        addSubview(contentView)
        addSubview(inputLabel)
        addSubview(inputTextfield)
        addSubview(inputMeasureLabel)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            contentView.heightAnchor.constraint(equalToConstant: 74),
        ])

        NSLayoutConstraint.activate([
            inputLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            inputLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ])

        NSLayoutConstraint.activate([
            inputTextfield.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            inputTextfield.widthAnchor.constraint(equalToConstant: 76),
            inputTextfield.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -53),
            inputTextfield.heightAnchor.constraint(equalToConstant: 34),
        ])

        NSLayoutConstraint.activate([
            inputMeasureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            inputMeasureLabel.leftAnchor.constraint(equalTo: inputTextfield.rightAnchor, constant: 10),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(label: String, measure: String) {
        inputLabel.text = label
        inputMeasureLabel.text = measure
    }
}
