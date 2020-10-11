//
//  MyPageActionsView.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//

import UIKit

class MyPageActionsView: UIView {

    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 16
        sv.distribution = .fillEqually
        return sv
    }()

    let bodyStep = MyPageActionView()
    let bmiCalculator = MyPageActionView()
    let settings = MyPageActionView()

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor(hex: "#ededed")
        addSubview(stackView)
        stackView.addArrangedSubview(bodyStep)
        stackView.addArrangedSubview(bmiCalculator)
        stackView.addArrangedSubview(settings)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 126),
        ])

        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
        ])

        bodyStep.configure(icon: "ic_body_state", text: "Body State")
        bmiCalculator.configure(icon: "ic_bmi_calculator", text: "BMI Calculator")
        settings.configure(icon: "ion_fast-food", text: "Calories Checker")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
